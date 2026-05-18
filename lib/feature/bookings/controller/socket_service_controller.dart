// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:consultz/core/network/api_urls.dart';
import 'package:consultz/core/utils/share_preference/auth_preference.dart';
import 'package:consultz/feature/bookings/controller/msg_controller.dart';
import 'package:consultz/feature/bookings/model/chat_message_model.dart';
import 'package:consultz/feature/call/controller/call_socket.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:get/get.dart';

class SocketServiceController extends GetxController {
  IO.Socket? socket;
  Future<void> init() async {
    log("Check");
    
    if (socket != null && socket!.connected) {
      log("🔴 Disconnecting previous socket connection");
      socket!.disconnect();
    }

    socket = IO.io(ApiUrls.socketUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'token': AuthPreference.logInToken},
    });

    socket!.on('connect', (_) {
      log('✅ Connected to the server');
    });

    socket!.onConnect((_) async {
      log('🟢 Socket connected');
    });
    socket!.onDisconnect((_) async {
      log('🔴 Socket disconnected');
    });

    CallSocket.bind(socket!);
  }

  void newMessageOn() {
    final msgController = Get.find<MsgController>();
    socket?.on('new-message', (data) {
      log('🔥🔥 New message data received from socket: $data');
      if (data != null) {
        final newMessage = ChatMessageData.fromJson(data);
        msgController.addNewMessage(newMessage);
      }
    });
  }

  void sendMessageEmit({
    required String receiverId,
    required String bookingId,
    required String text,
    required List<String> imageUrl,
  }) {
    socket?.emit('send-message', {
      "receiverId": receiverId,
      "bookingId": bookingId,
      "text": text,
      "imageUrl": imageUrl,
    });
  }

  Future<void> disconnect() async {
    socket?.disconnect();
  }
}
