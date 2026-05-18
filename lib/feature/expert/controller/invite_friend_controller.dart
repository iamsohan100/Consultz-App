// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vibration/vibration.dart';

class InviteFriendController extends GetxController {
  final referalCode = "".obs;
  final isCoppied = false.obs;
  final playStoreUrl = "www.playstore.com".obs;
  final appStoreUrl = "www.appstore.com".obs;
  final inviteFrndImage = AppImages.inviteFrnd;

  void inviteFriend() async {
    try {
      final byteData = await rootBundle.load(inviteFrndImage);
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/invite.png');
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );

      final inviteLink =
          "https://consultz-e39b8.web.app/invite?code=${referalCode.value}";

      final shareText =
          '''Hey, I’ve just joined Consultz as an expert and I’d like to invite you to join too because I recognise your knowledge, experience, and expertise.

Consultz is an invitation only platform where experts can monetise their knowledge through paid consultations, mentoring, and advice.

I think you’d be a great fit.


🎁 Referral Code: ${referalCode.value}

🔗 Join here: $inviteLink''';

      await Share.shareXFiles([XFile(file.path)], text: shareText);
    } catch (e) {
      bottomMessage(msg: 'Could not share the invite link.');
    }
  }

  void copyReferalCode() async {
    Clipboard.setData(ClipboardData(text: referalCode.value));
    isCoppied.value = true;
    Future.delayed(Duration(seconds: 1), () {
      isCoppied.value = false;
    });
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 100);
    }
  }
}
