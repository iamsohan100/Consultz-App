import 'dart:developer';

import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneFormField extends StatefulWidget {
  final TextEditingController controller;
  final RxString initCountryCode;
  const PhoneFormField({super.key, required this.controller, required this.initCountryCode});

  @override
  State<PhoneFormField> createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.initCountryCode.value = "+44";
      widget.controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        CustomText(
          text: 'Phone number',
          color: AppColors.black,
          fontSize: 12,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.4,
        ),
        SizedBox(height: height * 0.01),
        IntlPhoneField(
          controller: widget.controller,
          initialCountryCode: 'GB',
          dropdownIcon: Icon(
            Icons.expand_more,
            size: scaleFactor * 20,
            color: AppColors.darkGrey,
          ),

          pickerDialogStyle: PickerDialogStyle(
            backgroundColor: AppColors.white,
          ),
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.phone,
          showCountryFlag: false,
          dropdownIconPosition: IconPosition.trailing,
          flagsButtonPadding: EdgeInsetsGeometry.only(left: width * 0.02),

          style: GoogleFonts.figtree(
            fontSize: scaleFactor * 14,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            letterSpacing: 0.4,
          ),
          decoration: InputDecoration(
            hintText: 'Your phone number',

            hintStyle: GoogleFonts.figtree(
              fontSize: scaleFactor * 14,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,

              letterSpacing: 0.4,
            ),
            filled: true,
            fillColor: AppColors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: scaleFactor * 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(scaleFactor * 14),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(scaleFactor * 14),
              borderSide: BorderSide(color: AppColors.midGrey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(scaleFactor * 14),
              borderSide: BorderSide(color: AppColors.primaryColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(scaleFactor * 14),
              borderSide: BorderSide(color: AppColors.red, width: 1),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(scaleFactor * 14),
              borderSide: BorderSide(color: AppColors.red, width: 1),
            ),
          ),

          onCountryChanged: (country) {
            widget.initCountryCode.value = "+${country.dialCode}";
            log(widget.initCountryCode.value);
          },
    
          validator: (value) {
            if (value!.isValidNumber()) {
              return null;
            }
            return 'number is inValid';
          },
        ),
      ],
    );
  }
}
