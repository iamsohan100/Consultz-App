import 'dart:io';

import 'package:consultz/core/constants/app_colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class PickImageService {
  ImagePicker imagePicker = ImagePicker();


 Future<List<XFile>> pickMixedMedia() async {
  final List<XFile> files = await imagePicker.pickMultipleMedia();
  return files;
}

  Future<File?> pickProfileImge({
    required ImageSource source,
    CropStyle? cropeStyle,
    CropAspectRatioPreset? initAspectRatio,
  }) async {
    final XFile? file = await imagePicker.pickImage(
      source: source,
      imageQuality: 50,
    );

    if (file != null) {
      final cropped = await ImageCropper().cropImage(
        compressQuality: 50,
        sourcePath: file.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: AppColors.primaryColor,
            toolbarWidgetColor: AppColors.white,
            initAspectRatio: initAspectRatio ?? CropAspectRatioPreset.square,
            cropStyle: cropeStyle ?? CropStyle.circle,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
            title: 'Cropper',
            aspectRatioLockEnabled: false,
            cropStyle: cropeStyle ?? CropStyle.circle,
          ),
        ],
      );
      if (cropped != null) {
        return File(cropped.path);
      } else {
        return null;
      }
    } else {
      return null;
    }
  }
}
