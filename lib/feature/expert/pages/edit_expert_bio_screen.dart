import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/expert/controller/update_expert_bio_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditExpertBioScreen extends StatefulWidget {
  const EditExpertBioScreen({super.key});

  @override
  State<EditExpertBioScreen> createState() => _EditExpertBioScreenState();
}

class _EditExpertBioScreenState extends State<EditExpertBioScreen> {
  final updateBioController = Get.find<UpdateExpertBioController>();
  final profileController = Get.find<ProfileController>();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    updateBioController.bioController.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = profileController.expertProfileModel.value.data;
      updateBioController.bioController.text = data?.bio ?? '';
    });
  }

  static const int _maxChars = 300;
  int _charsLeft = _maxChars;

  void _onTextChanged() {
    final text = updateBioController.bioController.text;

    if (text.length > _maxChars) {
      final trimmed = text.substring(0, _maxChars);
      updateBioController.bioController.value = TextEditingValue(
        text: trimmed,
        selection: TextSelection.collapsed(offset: trimmed.length),
      );
      setState(() => _charsLeft = 0);
      return;
    }

    setState(() => _charsLeft = _maxChars - text.length);
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Bio',
        actions: [
          GestureDetector(
            onTap: _updateBio,
            child: CustomText(
              text: 'Done',
              color: AppColors.primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(width: width * 0.05),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsGeometry.all(scaleFactor * 14),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomFormField(
                    controller: updateBioController.bioController,
                    hintText: 'Enter your bio',
                    minLine: 4,
                    maxLine: 20,
                    padding: scaleFactor * 16,
                  ),
                  SizedBox(height: height * 0.015),
                  CustomText(
                    text: '$_charsLeft left',
                    color: _charsLeft == 0 ? Colors.red : AppColors.darkGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateBio() async {
    if (!_formKey.currentState!.validate()) return;
    bool isSuccess = await updateBioController.updateBio(context);
    if (isSuccess && mounted) {
      topMessage(msg: 'Bio updated successfully', title: 'Successful');
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    updateBioController.bioController.removeListener(_onTextChanged);
    super.dispose();
  }
}
