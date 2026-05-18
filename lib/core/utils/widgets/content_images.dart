// import 'package:consultz/feature/expert/model/content_data.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/media_item.dart';
import 'package:flutter/material.dart';

class ContentImages extends StatelessWidget {
  const ContentImages({super.key, this.content});
  final List<String>? content;
  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return SizedBox(
      height: height * 0.35,
      child: ListView.separated(
        itemCount: content!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return AspectRatio(
            aspectRatio: 1 / 1.1,
            child: Container(
              margin: EdgeInsets.only(
                left: content!.first == content![index] ? scaleFactor * 14 : 0,
                right: content!.last == content![index] ? scaleFactor * 14 : 0,
              ),

              child: MediaItem(url: content![index], fit: BoxFit.cover),
            ),
          );
        },
        separatorBuilder: (_, _) {
          return SizedBox(width: width * 0.015);
        },
      ),
    );
  }
}
