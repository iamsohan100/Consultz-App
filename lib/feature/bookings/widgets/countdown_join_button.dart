import 'dart:async';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/button/primary_button.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/feature/bookings/widgets/join_call_button.dart';
import 'package:flutter/material.dart';

class CountdownJoinButton extends StatefulWidget {
  const CountdownJoinButton({
    super.key,
    required this.startTime,
    required this.name,
    required this.duration,
    required this.bookingId,
    required this.receiverUserId,
    required this.image,
    this.status,
  });

  final DateTime startTime;
  final String name;
  final int duration;
  final String bookingId;
  final String? status;
  final String receiverUserId;
  final String image;

  @override
  State<CountdownJoinButton> createState() => _CountdownJoinButtonState();
}

class _CountdownJoinButtonState extends State<CountdownJoinButton> {
  Timer? _timer;
  late Duration _timeLeft;
  late DateTime _endTime;

  @override
  void initState() {
    super.initState();
    _endTime = widget.startTime.add(Duration(minutes: widget.duration));
    _calculateTimeLeft();
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateTimeLeft() {
    final now = DateTime.now();
    _timeLeft = widget.startTime.difference(now);
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.isAfter(_endTime) ||
          widget.status?.toLowerCase() == 'completed') {
        _timer?.cancel();
      }
      setState(() {
        _calculateTimeLeft();
      });
    });
  }

  String _formatDuration(Duration duration) {
    if (duration.isNegative) return "00:00:00";

    int days = duration.inDays;
    int hours = duration.inHours.remainder(24);
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    String daysStr = days > 0 ? "${days}d " : "";
    String hoursStr = hours.toString().padLeft(2, '0');
    String minutesStr = minutes.toString().padLeft(2, '0');
    String secondsStr = seconds.toString().padLeft(2, '0');

    return "$daysStr$hoursStr:$minutesStr:$secondsStr";
  }

  @override
  Widget build(BuildContext context) {
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final now = DateTime.now();
    if (now.isAfter(_endTime) || widget.status?.toLowerCase() == 'completed') {
      return const SizedBox.shrink();
    }

    if (_timeLeft.isNegative || _timeLeft == Duration.zero) {
      // Countdown finished – show the join button
      return JoinCallButton(
        name: widget.name,
        bookingId: widget.bookingId,
        receiverUserId: widget.receiverUserId,
        image: widget.image,
      );
    }

    return Container(
      padding: EdgeInsets.only(
        top: scaleFactor * 15,
        left: scaleFactor * 20,
        right: scaleFactor * 20,
        bottom: scaleFactor * 30,
      ),
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.04),
            blurRadius: 20,
            spreadRadius: 0.12,
            offset: const Offset(0, -20),
          ),
        ],
      ),
      child: PrimaryButton(
        onPressed: null, // Disabled
        padding: 0.1,
        title: 'Starts in: ${_formatDuration(_timeLeft)}',
        backgroundColor: AppColors.midGrey,
        textColor: AppColors.darkGrey,
      ),
    );
  }
}
