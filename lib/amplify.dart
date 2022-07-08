// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:flutter/widgets.dart';
import 'amplifyconfiguration.dart';

class RenderAmplify {
  static Future<void> configure() async {
    final authPlugin = AmplifyAuthCognito();
    try {
      await Amplify.addPlugins([authPlugin]);
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      debugPrint(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }
}
