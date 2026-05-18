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

class UpdateJobRoleScreen extends StatefulWidget {
  const UpdateJobRoleScreen({super.key});

  @override
  State<UpdateJobRoleScreen> createState() => _UpdateJobRoleScreenState();
}

class _UpdateJobRoleScreenState extends State<UpdateJobRoleScreen> {
  final profileController = Get.find<ProfileController>();
  final updateNameController = Get.find<UpdateNameController>();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final data = profileController.expertProfileModel.value.data;
      updateNameController.jobRoleController.text = data?.headline ?? '';
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
        title: 'Job role',
        actions: [
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                editConfarmatonDialog(
                  onTapYes: updateJobRole,
                  context: context,
                  title: 'Are you sure you want to change your job role to ',
                  subtitle: updateNameController.jobRoleController.text,
                  buttonText: 'role',
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
                    text: 'Your job role is visible to everyone on Consultz.',
                    color: AppColors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  SizedBox(height: height * 0.02),

                  CustomFormField(
                    controller: updateNameController.jobRoleController,
                    title: 'Job role',

                    hintText: 'Enter job role',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> updateJobRole() async {
    bool isSuccess = await updateNameController.updateJobRole(context);
    if (isSuccess && mounted) {
      topMessage(msg: 'Job role updated successfully', title: 'Successful');
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }
}
