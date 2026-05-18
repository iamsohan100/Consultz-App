// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:consultz/core/utils/message/bottom_message.dart';
import 'package:path_provider/path_provider.dart';
import 'package:consultz/core/constants/app_images.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';

class ProfileShareController extends GetxController {
  final profileLink = "https://consultz-e39b8.web.app".obs;

  void shareProfile({bool? isMy, String? expertId}) async {
    String link = profileLink.value;
    
    if (expertId != null) {
      link = "https://consultz-e39b8.web.app/expert/$expertId";
    }

    try {
      final byteData = await rootBundle.load(
        isMy == true ? AppImages.shareProfile : AppImages.shareExpert,
      );
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/invite.png');
      await file.writeAsBytes(
        byteData.buffer.asUint8List(
          byteData.offsetInBytes,
          byteData.lengthInBytes,
        ),
      );

      final shareText = isMy == true
          ? '''Want to speak with me 1-to-1?

You can now book a video consultation directly through my Consultz profile👇

Profile Link: $link

Ask your questions, get tailored advice, and move forward faster.'''
          : '''Just found this app called Consultz👇

You can book 1-to-1 video calls with highly qualified experts and get real advice instantly.

No more guessing, just speak directly to someone who knows what they're doing.

Check it out: $link''';

      await Share.shareXFiles([XFile(file.path)], text: shareText);
    } catch (e) {
      bottomMessage(msg: 'Could not share the invite link.');
    }
  }
}
