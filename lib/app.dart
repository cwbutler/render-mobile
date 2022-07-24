import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:render/amplify.dart';
import 'package:render/auth_model.dart';
import 'package:render/models/auth.dart';
// Pages (Screens)
import 'package:render/home.dart';
import 'package:render/login.dart';
import 'package:render/create_user/create_user.dart';
import 'package:render/create_user/professional.dart';
import 'package:render/create_user/location.dart';
import 'package:render/create_user/profile_pic.dart';

class RenderApp extends HookConsumerWidget {
  const RenderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Default status bar to 'light'
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final user = ref.watch(userProvider);
    final setCurrentUser = ref.read(userProvider.notifier).setCurrentUser;
    final isLoading = useState(true);

    Future<Null Function()> _init() async {
      await RenderAmplify.configure();
      final user = await AuthModel.getCurrentUser();

      if (user.id.isNotEmpty) {
        setCurrentUser(user);
      }

      StreamSubscription<HubEvent> hubSubscription =
          Amplify.Hub.listen([HubChannel.Auth], (hubEvent) async {
        switch (hubEvent.eventName) {
          case 'SIGNED_IN':
            setCurrentUser(await AuthModel.getCurrentUser());
            break;
          case 'SIGNED_OUT':
            await Amplify.DataStore.clear();
            break;
          case 'SESSION_EXPIRED':
            debugPrint('SESSION HAS EXPIRED');
            break;
          case 'USER_DELETED':
            debugPrint('USER HAS BEEN DELETED');
            break;
        }
      });

      return () {
        hubSubscription.cancel();
      };
    }

    useEffect(() {
      _init().then((value) {
        isLoading.value = false;
      });
      return null;
    }, []);

    return MaterialApp(
      title: 'Render Conference App',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: const Color(0xffff88df),
          backgroundColor: Colors.black,
          fontFamily: 'Gothic A1',
          disabledColor: Colors.black,
          inputDecorationTheme: const InputDecorationTheme(
              contentPadding: EdgeInsets.only(bottom: 6),
              floatingLabelStyle: TextStyle(
                  color: Color(0xffff88df),
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffff88df))))),
      debugShowCheckedModeBanner: false,
      home: (isLoading.value)
          ? const Center(child: CircularProgressIndicator())
          : (user.email.isEmpty)
              ? const LoginScreen()
              : (user.createdAt == null)
                  ? const CreateUser()
                  : const HomeScreen(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'create/professional':
            return MaterialPageRoute(
                builder: (context) => const CreateUserProfessional());
          case 'create/location':
            return MaterialPageRoute(
                builder: (context) => const CreateUserLocation());
          case 'create/profile_pic':
            return MaterialPageRoute(
                builder: (context) => const CreateUserProfilePic());
          default:
            return MaterialPageRoute(
                builder: (context) => const UnknownScreen());
        }
      },
    );
  }
}

class UnknownScreen extends StatelessWidget {
  const UnknownScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('404!'),
      ),
    );
  }
}
