import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/core/utils/helpers/validation_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomFormField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? title;
  final String? hintText;
  final double? padding;
  final double? horPadding;
  final bool isPassword;
  final dynamic backgroundColor;
  final Widget? suffixIcon;
  final int? minLine;
  final int? maxLine;
  final VoidCallback? onTap;
  final bool readOnly;
  final String? initialValue;
  final Widget? prefixIcon;
  final bool? isValidator;
  final bool? isPhone;
  final bool? isMail;
  final bool? isRequired;
  final bool? isTitleError;
  final bool? isNumber;
  final ValueChanged<String>? onChange;
  final TextInputAction? textInputAction;
  final bool autofocus;
  final bool? isPasswordValidation;
  final String? Function(String?)? validator;

  const CustomFormField({
    super.key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.isPassword = false,
    this.backgroundColor,
    this.suffixIcon,
    this.minLine,
    this.maxLine,
    this.onTap,
    this.readOnly = false,
    this.prefixIcon,
    this.padding,
    this.onChange,
    this.initialValue,
    this.isValidator,
    this.isPhone,
    this.isMail,
    this.title,
    this.isRequired,
    this.horPadding,
    this.isTitleError,
    this.isNumber,
    this.textInputAction,
    this.autofocus = false,
    this.isPasswordValidation,
    this.validator,
  });

  @override
  State<CustomFormField> createState() => _CustomFormField();
}

class _CustomFormField extends State<CustomFormField> {
  bool obSecure = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // বাইরে থেকে আসলে সেটা use করো, না হলে নিজে বানাও
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // বাইরে থেকে আসা focusNode dispose করবো না — owner নিজেই করবে
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: widget.title!,
                color: AppColors.black,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              if (widget.isRequired != null)
                CustomText(
                  text: '*',
                  color: AppColors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
            ],
          ),
        if (widget.title != null) SizedBox(height: height * 0.01),
        TextFormField(
          focusNode: _focusNode,
          autofocus: widget.autofocus,
          keyboardType: widget.isNumber == true
              ? TextInputType.number
              : widget.isPhone == true
              ? TextInputType.phone
              : widget.isMail == true
              ? TextInputType.emailAddress
              : null,
          initialValue: widget.initialValue,
          cursorColor: AppColors.primaryColor,
          onChanged: widget.onChange,
          onTap: widget.onTap,
          controller: widget.controller,
          readOnly: widget.readOnly,
          minLines: widget.minLine ?? 1,
          maxLines: widget.maxLine ?? 1,
          textInputAction: widget.textInputAction ?? TextInputAction.done,
          validator: widget.validator ??
              ((widget.isPasswordValidation == true)
                  ? ValidationHelper.validatePassword
                  : (widget.isValidator == false
                      ? null
                      : widget.isMail == true
                          ? (value) {
                              if (value?.trim().isEmpty ?? true) {
                                return 'e-mail can not be empty';
                              } else if (RegExp(
                                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                              ).hasMatch(value!)) {
                                return null;
                              }
                              return "Please enter valid e-mail";
                            }
                          : widget.isPhone == true
                              ? (value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return '${widget.hintText} can not be empty';
                                  } else if (RegExp(r'^\+?[0-9]{11}$')
                                      .hasMatch(value!)) {
                                    return null;
                                  }
                                  return "Please enter valid phone number";
                                }
                              : (value) {
                                  if (value!.isEmpty) {
                                    return '${widget.isTitleError == true ? widget.title : widget.hintText} can not be empty';
                                  }
                                  return null;
                                })),
          style: GoogleFonts.figtree(
            fontSize: scaleFactor * 14,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
            letterSpacing: 0.4,
          ),
          obscureText: widget.isPassword && obSecure,
          decoration: InputDecoration(
            filled: true,
            fillColor: (widget.backgroundColor == null)
                ? AppColors.white
                : widget.backgroundColor,
            contentPadding: EdgeInsets.symmetric(
              vertical: widget.padding ?? 0,
              horizontal: widget.horPadding ?? scaleFactor * 20,
            ),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.isPassword
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        obSecure = !obSecure;
                      });
                    },
                    child: Icon(
                      (widget.isPassword && obSecure)
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      size: scaleFactor * 20,
                      color: AppColors.grey,
                    ),
                  )
                : widget.suffixIcon,
            hintText: widget.hintText,
            hintStyle: GoogleFonts.figtree(
              fontSize: scaleFactor * 14,
              fontWeight: FontWeight.w400,
              color: AppColors.grey,
              letterSpacing: 0.4,
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
        ),
      ],
    );
  }
}