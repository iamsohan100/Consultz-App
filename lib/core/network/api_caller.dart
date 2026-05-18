// ignore_for_file: body_might_complete_normally_nullable

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:consultz/core/network/network_response_model.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:http/http.dart';

class ApiCaller {
  // get request
  static Future<ResponseModel?> getRequest({required String url}) async {
    try {
      final Response response = await get(
        Uri.parse(url),
        headers: {
          'Authorization': '${AuthPreference.logInToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final decodeResponse = jsonDecode(response.body);

      return ResponseModel(
        statusCode: response.statusCode,
        isSuccess: decodeResponse['success'] ?? false,
        message: decodeResponse['message'],
        responseData: decodeResponse,
      );
    } on SocketException {
      topMessage(
        title: "No Internert!",
        msg: 'No Internet connection available.',
      );
    } on TimeoutException {
      topMessage(title: "Failed", msg: 'Request timed out. Please try again.');
    }
  }

  // post request
  static Future<ResponseModel?> postRequest({
    required String url,
    String? token,
    Map<String, dynamic>? body,
  }) async {
    try {
      final Response response = await post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Authorization': token ?? '${AuthPreference.logInToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      final decodeResponse = jsonDecode(response.body);
      return ResponseModel(
        statusCode: response.statusCode,
        isSuccess: decodeResponse['success'] ?? false,
        message: decodeResponse['message'],
        responseData: decodeResponse,
      );
    } on SocketException {
      topMessage(
        title: "No Internert!",
        msg: 'No Internet connection available.',
      );
    } on TimeoutException {
      topMessage(title: "Failed", msg: 'Request timed out. Please try again.');
    }
  }

  // put request
  static Future<ResponseModel?> putRequest({
    required String url,
    String? token,

    dynamic body,
  }) async {
    try {
      final Response response = await put(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Authorization': token ?? '${AuthPreference.logInToken}',
          'Content-type': 'application/json',
        },
      );

      final decodeResponse = jsonDecode(response.body);

      return ResponseModel(
        statusCode: response.statusCode,
        isSuccess: decodeResponse['success'] ?? false,
        message: decodeResponse['message'],
        responseData: decodeResponse,
      );
    } on SocketException {
      topMessage(
        title: "No Internert!",
        msg: 'No Internet connection available.',
      );
    } on TimeoutException {
      topMessage(title: "Failed", msg: 'Request timed out. Please try again.');
    }
  }

  // Patch request
  static Future<ResponseModel?> patchRequest({
    required String url,
    dynamic body,
  }) async {
    try {
      final Response response = await patch(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: {
          'Authorization': '${AuthPreference.logInToken}',
          'Content-type': 'application/json',
        },
      );

      final decodeResponse = jsonDecode(response.body);

      return ResponseModel(
        statusCode: response.statusCode,
        isSuccess: decodeResponse['success'] ?? false,
        message: decodeResponse['message'],
        responseData: decodeResponse,
      );
    } on SocketException {
      topMessage(
        title: "No Internert!",
        msg: 'No Internet connection available.',
      );
    } on TimeoutException {
      topMessage(title: "Failed", msg: 'Request timed out. Please try again.');
    }
  }

  // delete request
  static Future<ResponseModel?> deleteRequest({required String url}) async {
    try {
      final Response response = await delete(
        Uri.parse(url),
        headers: {
          'Authorization': '${AuthPreference.logInToken}',
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final decodeResponse = jsonDecode(response.body);

      return ResponseModel(
        statusCode: response.statusCode,
        isSuccess: decodeResponse['success'] ?? false,
        message: decodeResponse['message'],
        responseData: decodeResponse,
      );
    } on SocketException {
      topMessage(
        title: "No Internert!",
        msg: 'No Internet connection available.',
      );
    } on TimeoutException {
      topMessage(title: "Failed", msg: 'Request timed out. Please try again.');
    }
  }

  // form api request
  static Future<ResponseModel?> formRequest({
    String? token,
    required String method,
    required String url,
    Map<String, String>? fields,
    Map<String, File?>? files,
    Map<String, List<File>>? multipleFiles, // ✅ নতুন parameter
  }) async {
    try {
      var request = MultipartRequest(method, Uri.parse(url));
      request.headers.addAll({
        'Authorization': token ?? '${AuthPreference.logInToken}',
        'Content-Type': 'application/json; charset=UTF-8',
      });

      if (fields != null && fields.isNotEmpty) {
        request.fields.addAll(fields);
      }

      // আগের single file logic — অপরিবর্তিত
      if (files != null && files.isNotEmpty) {
        for (var entry in files.entries) {
          if (entry.value != null) {
            request.files.add(
              await MultipartFile.fromPath(
                entry.key,
                entry.value!.path,
              ),
            );
          }
        }
      }

      // ✅ Multiple files — same key দিয়ে সবগুলো attach
      if (multipleFiles != null && multipleFiles.isNotEmpty) {
        for (var entry in multipleFiles.entries) {
          for (var file in entry.value) {
            request.files.add(
              await MultipartFile.fromPath(
                entry.key,
                file.path,
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
    }
  }
}
