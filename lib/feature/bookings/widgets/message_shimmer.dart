import 'package:consultz/core/utils/loading.dart/shimmer_loading.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:flutter/material.dart';

class MessageShimmer extends StatelessWidget {
  const MessageShimmer({super.key, this.length = 12});
  final int length;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          SizedBox(height: height * 0.02),
          for (int i = 0; i < length; i++)
            _buildShimmerItem(context, i, width, height, scaleFactor),
        ],
      ),
    );
  }

  Widget _buildShimmerItem(
    BuildContext context,
    int index,
    double width,
    double height,
    double scaleFactor,
  ) {
    bool isMe = index % 2 != 0; // Alternate bubbles

    return Padding(
      padding: EdgeInsets.only(bottom: height * 0.02),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            const ShimmerLoading(width: 32, height: 32, isCircle: true),
            SizedBox(width: width * 0.02),
          ],
          Column(
            crossAxisAlignment: isMe
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              ShimmerLoading(
                width: width * (0.4 + (index % 3) * 0.1), // Varying widths
                height: 45 * scaleFactor,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
