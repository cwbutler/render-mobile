import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static Future<void> launchWebView(Uri url) async {
    if (!await launchUrl(url, mode: LaunchMode.platformDefault)) {
      throw 'Could not launch $url';
    }
  }
}
