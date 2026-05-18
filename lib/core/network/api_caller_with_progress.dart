// ignore_for_file: body_might_complete_normally_nullable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:consultz/core/network/network_response_model.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:http/http.dart';
import 'package:mime/mime.dart';

class ApiCallerWithProgress {
  static Future<ResponseModel?> formRequest({
    String? token,
    required String method,
    required String url,
    Map<String, String>? fields,
    Map<String, File?>? files,
    Map<String, List<File>>? multipleFiles,
    Function(double)? onProgress,
  }) async {
    try {
      var request = MultipartRequestWithProgress(method, Uri.parse(url),
          onProgress: onProgress);
      request.headers.addAll({
        'Authorization': token ?? '${AuthPreference.logInToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (fields != null && fields.isNotEmpty) {
        request.fields.addAll(fields);
      }

      if (files != null && files.isNotEmpty) {
        for (var entry in files.entries) {
          if (entry.value != null) {
            String mimeType =
                lookupMimeType(entry.value!.path) ?? 'application/octet-stream';
            request.files.add(
              await MultipartFile.fromPath(
                entry.key,
                entry.value!.path,
                contentType: MediaType.parse(mimeType),
              ),
            );
          }
        }
      }

      if (multipleFiles != null && multipleFiles.isNotEmpty) {
        for (var entry in multipleFiles.entries) {
          for (var file in entry.value) {
            String mimeType =
                lookupMimeType(file.path) ?? 'application/octet-stream';
            request.files.add(
              await MultipartFile.fromPath(
                entry.key,
                file.path,
                contentType: MediaType.parse(mimeType),
              ),
            );
          }
        }
      }

      var res = await request.send();
      var response = await res.stream.bytesToString();
      final decodeResponse = json.decode(response);
      
      return ResponseModel(
        statusCode: res.statusCode,
        isSuccess: decodeResponse['success'] ?? false,
        message: decodeResponse['message'],
        responseData: decodeResponse,
      );
    } on SocketException {
      topMessage(
        title: "No Internet!",
        msg: 'No Internet connection available.',
      );
    } on TimeoutException {
      topMessage(title: "Failed", msg: 'Request timed out. Please try again.');
    } catch (e) {
      rethrow;
    }
  }
}

class MultipartRequestWithProgress extends MultipartRequest {
  final Function(double progress)? onProgress;

  MultipartRequestWithProgress(
    super.method,
    super.url, {
    this.onProgress,
  });

  @override
  ByteStream finalize() {
    final byteStream = super.finalize();
    if (onProgress == null) return byteStream;

    final total = contentLength;
    int bytes = 0;

    final t = StreamTransformer.fromHandlers(
      handleData: (List<int> data, EventSink<List<int>> sink) {
        bytes += data.length;
        if (total > 0) {
          // Cap upload progress at 95% to leave room for server processing
          onProgress!((bytes / total) * 0.95);
        }
        sink.add(data);
      },
    );
    final stream = byteStream.transform(t);
    return ByteStream(stream);
  }
}
