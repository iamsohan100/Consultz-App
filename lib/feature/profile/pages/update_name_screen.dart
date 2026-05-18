import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/message/top_message.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/app_bar/custom_appbar.dart';
import 'package:consultz/core/utils/form_field/custom_form_field.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/Auth/controller/profile_controller.dart';
import 'package:consultz/feature/profile/controller/update_name_controller.dart';
import 'package:consultz/feature/profile/widgets/edit_confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateNameScreen extends StatefulWidget {
  const UpdateNameScreen({super.key});

  @override
  State<UpdateNameScreen> createState() => _UpdateNameScreenState();
}

class _UpdateNameScreenState extends State<UpdateNameScreen> {
  final profileController = Get.find<ProfileController>();
  final updateNameController = Get.find<UpdateNameController>();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = profileController.expertProfileModel.value.data;
      updateNameController.firstNameController.text = data?.firstName ?? '';
      updateNameController.lastNameController.text = data?.lastName ?? '';
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;
    return Scaffold(
      appBar: customAppBar(
        context: context,
        title: 'Name',
        actions: [
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                editConfarmatonDialog(
                  onTapYes: updateName,
                  context: context,
                  title: 'Are you sure you want to change your name to ',
                  subtitle:
                      '${updateNameController.firstNameController.text} ${updateNameController.lastNameController.text}',
                  buttonText: 'name',
                );
              }
            },
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
                  CustomText(
                    text: 'Your name is visible to everyone on Consultz.',
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: height * 0.02),

                  CustomFormField(
                    controller: updateNameController.firstNameController,
                    title: 'First name',

                    hintText: 'Enter first name',
                  ),
                  SizedBox(height: height * 0.02),
                  CustomFormField(
                    controller: updateNameController.lastNameController,
                    title: 'Last name',
                    hintText: 'Enter last name',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateName() async {
    bool isSuccess = await updateNameController.updateName(context);
    if (isSuccess && mounted) {
      topMessage(msg: 'Name updated successfully', title: 'Successful');
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
