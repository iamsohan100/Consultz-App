import 'package:consultz/feature/bookings/model/chat_message_model.dart';
import 'package:consultz/feature/bookings/widgets/chat_card.dart';
import 'package:flutter/material.dart';

class FirstPersonMsgCard extends StatelessWidget {
  const FirstPersonMsgCard({super.key, required this.message});
  final ChatMessageData message;

  @override
  Widget build(BuildContext context) {
    return ChatCard(message: message, isMe: true);
  }
}
