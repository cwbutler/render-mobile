import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

class RenderAppModel {
  static List<CameraDescription> cameras = [];
  static CameraDescription? camera;
  static late CameraController cameraController;

  const RenderAppModel();

  static Future<CameraController> getCameraController() async {
    if (camera != null) return cameraController;

    // Ensure that plugin services are initialized so that `availableCameras()`
    // can be called before `runApp()`
    WidgetsFlutterBinding.ensureInitialized();

    // Obtain a list of the available cameras on the device.
    cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    camera = cameras.first;

    cameraController = CameraController(camera!, ResolutionPreset.max);

    await cameraController.initialize();

    return cameraController;
  }

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

  static String daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    final numOfDays = (to.difference(from).inHours / 24).round();

    if (numOfDays == 0) return "Today";
    if (numOfDays == 1) return "Yesterday";
    if (numOfDays >= 7) return "${(numOfDays / 7).floor()}w";

    return "${numOfDays}d";
  }

  static Future<StreamSubscription?> initUniLinks() async {
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      final initialLink = await getInitialUri();
      if (initialLink != null) {
        debugPrint(initialLink.toString());
      }
      // Attach a listener to the stream
      final sub = uriLinkStream.listen((Uri? uri) {
        // Use the uri and warn the user, if it is not correct
      }, onError: (err) {
        // Handle exception by warning the user their action did not succeed
        debugPrint("sub error: ${err.toString()}");
      });

      return sub;
    } on PlatformException {
      // Handle exception by warning the user their action did not succeed
      // return?
      debugPrint("link error:");
    }
    return null;
  }
}
