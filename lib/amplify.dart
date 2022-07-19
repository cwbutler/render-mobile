// Amplify Flutter Packages
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:render/models/ModelProvider.dart';
import 'package:flutter/widgets.dart';
import 'amplifyconfiguration.dart';

class RenderAmplify {
  static Future<void> configure() async {
    try {
      final authPlugin = AmplifyAuthCognito();
      final api = AmplifyAPI(modelProvider: ModelProvider.instance);
      await Amplify.addPlugins([authPlugin, api]);
      await Amplify.configure(amplifyconfig);
    } on AmplifyAlreadyConfiguredException {
      debugPrint(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }
}
