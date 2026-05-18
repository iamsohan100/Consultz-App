// ignore_for_file: library_prefixes

import 'dart:developer';

import 'package:consultz/feature/call/controller/call_service_controller.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class CallSocket {
  static void bind(IO.Socket socket) {
    final callController = Get.find<CallServiceController>();
    callController.setSocket(socket);

    socket.off('callIncoming');
    socket.off('callAccepted');
    socket.off('callDeclined');
    socket.off('callCanceled');
    socket.off('callEnded');

    socket.on('callIncoming', (data) {
      log('📞 Socket Event: callIncoming - $data');
      callController.handleCallIncoming(data);
    });

    socket.on('callAccepted', (data) {
      log('📞 Socket Event: callAccepted - $data');
      callController.handleCallAccepted(data);
    });

    socket.on('callDeclined', (data) {
      log('📞 Socket Event: callDeclined - $data');
      callController.handleCallDeclined(data);
    });

    socket.on('callCanceled', (data) {
      log('📞 Socket Event: callCanceled - $data');
      callController.handleCallCanceled(data);
    });

    socket.on('callEnded', (data) {
      log('📞 Socket Event: callEnded - $data');
      callController.handleCallEnded(data);
    });

    socket.on('bookingComplete', (data) {
      log('📞 Socket Event: bookingComplete - $data');
      callController.handleBookingComplete(data);
    });
  }

  static void unbind(IO.Socket socket) {
    socket.off('callIncoming');
    socket.off('callAccepted');
    socket.off('callDeclined');
    socket.off('callCanceled');
    socket.off('callEnded');
  }
}
