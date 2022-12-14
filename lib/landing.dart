// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:render/models/app.dart';
import 'firebase_options.dart';
import 'package:render/models/auth.dart';

class RenderAppLanding extends HookConsumerWidget {
  const RenderAppLanding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchCurrentUser = ref.read(userProvider.notifier).fetchCurrentUser;

    navigate(String routeName) {
      Navigator.popAndPushNamed(context, routeName);
    }

    Future<void> init() async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      await RenderAppModel.askTrackingPermissions();
      await RenderAppModel.preloadImages(context);

      final auth = await fetchCurrentUser();
      String nextRoute = (auth.hasProfile) ? 'home' : 'create';

      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        debugPrint('Got a message whilst in the foreground!');
        debugPrint('Message data: ${message.data}');

        if (message.notification != null) {
          debugPrint(
            'Message also contained a notification: ${message.notification!.title}',
          );
        }
      });

      return navigate(
          (auth.user == null || auth.user!.uid.isEmpty) ? 'login' : nextRoute);
    }

    useEffect(() {
      init();
      return null;
    }, []);

    return const Center(child: CircularProgressIndicator());
  }
}
