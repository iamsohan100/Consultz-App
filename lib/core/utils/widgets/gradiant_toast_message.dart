// import 'package:consultz/route/route_constant.dart';
// import 'package:consultz/core/constants/app_colors.dart';
// import 'package:consultz/core/utils/responsive/screen.dart';
// import 'package:consultz/core/utils/text/custom_text.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class AnimatedGradientToast extends StatefulWidget {
//   final String message;
//   final VoidCallback onClose;
//   final VoidCallback onTap;

//   const AnimatedGradientToast({
//     super.key,
//     required this.message,
//     required this.onClose,
//     required this.onTap,
//   });

//   @override
//   State<AnimatedGradientToast> createState() => _AnimatedGradientToastState();
// }

// class _AnimatedGradientToastState extends State<AnimatedGradientToast>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Offset> _offsetAnimation;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();

//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 400),
//       vsync: this,
//     );

//     _offsetAnimation = Tween<Offset>(
//       begin: const Offset(0, -1.0),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = Screen.screenHeight(context);
//     final width = Screen.screenWidth(context);
//     final scalefactor = width / Screen.designWidth;

//     return SlideTransition(
//       position: _offsetAnimation,
//       child: FadeTransition(
//         opacity: _fadeAnimation,
//         child: GestureDetector(
//           onTap: widget.onTap,
//           child: Container(
//             margin: EdgeInsets.symmetric(
//               horizontal: width * 0.04,
//               vertical: height * 0.01,
//             ),
//             padding: EdgeInsets.symmetric(
//               horizontal: scalefactor * 16,
//               vertical: scalefactor * 10,
//             ),
//             decoration: BoxDecoration(
//               gradient: const LinearGradient(
//                 colors: [Color(0xFFB155A1), Color(0xFFD83578)],
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//               ),
//               borderRadius: BorderRadius.circular(scalefactor * 12),
//             ),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: CustomText(
//                     text: widget.message,
//                     color: AppColors.white,
//                     fontSize: 14,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//                 SizedBox(width: width * 0.01),
//                 GestureDetector(
//                   onTap: () {
//                     _controller.reverse().then((_) {
//                       widget.onClose();
//                     });
//                   },
//                   child: Icon(
//                     Icons.close,
//                     color: AppColors.white,
//                     size: scalefactor * 20,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// void showGradientToast(BuildContext context, String message) {
//   late OverlayEntry overlayEntry;

//   overlayEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: 0,
//       left: 0,
//       right: 0,
//       child: Material(
//         color: Colors.transparent,
//         child: SafeArea(
//           child: AnimatedGradientToast(
//             message: message,
//             onClose: () {
//               overlayEntry.remove();
//             },
//             onTap: () {
//               overlayEntry.remove();
//               Get.toNamed(RoutesConstant.bookingDetailsScreen);
//             },
//           ),
//         ),
//       ),
//     ),
//   );

//   Overlay.of(context).insert(overlayEntry);
// }
