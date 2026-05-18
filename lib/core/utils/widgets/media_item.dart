import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/video_place_holder.dart';
import 'package:consultz/feature/discover/model/media_helper.dart';
import 'package:flutter/material.dart';

// ── Single media item ───────────────────────────────────────────────────────
class MediaItem extends StatelessWidget {
  const MediaItem({
    super.key,
    required this.url,
    required this.fit,
    this.isSingle,
  });
  final bool? isSingle;
  final String url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    // final double height = Screen.screenHeight(context);
    final double width = Screen.screenWidth(context);
    // final double scaleFactor = width / Screen.designWidth;
    if (MediaHelper.isVideo(url)) {
      return VideoPlaceholder(url: url);
    }

    return DisplayNetworkImage(
      imageUrl: url,
      imageFit: fit,
      imageSize: isSingle == true ? width : (width * 0.45),
      radius: isSingle == true ? 0 : 6,
    );
  }
}
