import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class RenderAppModel {
  static Future<File?> getImageFromDevice() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null && result.files.first.path != null) {
      PlatformFile file = result.files.first;
      return File(file.path!);
    } else {
      // User canceled the picker
    }

    return null;
  }
}
