import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
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

    Future<void> _init() async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      final auth = await fetchCurrentUser();
      String nextRoute = (auth.hasProfile) ? 'home' : 'create';

      if (auth.user == null || auth.user!.uid.isEmpty) {
        return navigate('login');
      }

      navigate(nextRoute);
    }

    useEffect(() {
      _init();
      return null;
    }, []);

    return const Center(child: CircularProgressIndicator());
  }
}
