// lib/feature/discover/widgets/image_slider.dart

import 'package:carousel_slider/carousel_slider.dart';
import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/image/display_network_image.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/widgets/video_place_holder.dart';
import 'package:consultz/feature/discover/model/media_helper.dart';
import 'package:flutter/material.dart';

class ImageSlider extends StatefulWidget {
  const ImageSlider({super.key, required this.content});

  /// Mixed list — can contain image URLs or video URLs
  final List<String> content;

  @override
  State<ImageSlider> createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  final ValueNotifier<int> _currentIndex = ValueNotifier(0);

  @override
  void dispose() {
    _currentIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double height = Screen.screenHeight(context);
    final double width = Screen.screenWidth(context);
    final double scaleFactor = width / Screen.designWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: height * 0.7,
            viewportFraction: 1,
            enableInfiniteScroll: false,
            autoPlay: false,
            onPageChanged: (index, _) => _currentIndex.value = index,
          ),
          items: widget.content.map((url) {
            return MediaHelper.isVideo(url)
                ? VideoPlaceholder(url: url)
                : InteractiveViewer(
                    child: DisplayNetworkImage(
                      imageUrl: url,
                      imageWidth: width,
                      imageHeight: height * 0.7,
                      radius: 0,
                    ),
                  );
          }).toList(),
        ),

        // Dot indicators
        SizedBox(height: height * 0.012),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.04),
          child: ValueListenableBuilder<int>(
            valueListenable: _currentIndex,
            builder: (_, index, _) {
              return Row(
                children: List.generate(widget.content.length, (i) {
                  final isActive = i == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: height * 0.007,
                    width: isActive ? width * 0.06 : width * 0.02,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(
                        isActive ? scaleFactor * 16 : 100,
                      ),
                    ),
                  );
                }),
              );
            },
          ),
        ),
      ],
    );
  }
}
