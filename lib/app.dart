import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:render/models/events.dart';
import 'package:render/screens/profile/edit.dart';
import 'package:render/screens/profile/profile.dart';
import 'package:render/screens/settings.dart';
import 'firebase_options.dart';
import 'package:render/models/auth.dart';
// Pages (Screens)
import 'package:render/screens/home/home.dart';
import 'package:render/screens/login/login.dart';
import 'package:render/screens/create_user/create_user.dart';
import 'package:render/screens/create_user/professional.dart';
import 'package:render/screens/create_user/location.dart';
import 'package:render/screens/create_user/profile_pic.dart';

class RenderApp extends HookConsumerWidget {
  const RenderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Default status bar to 'light'
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final auth = ref.watch(userProvider);
    final setCurrentUser = ref.read(userProvider.notifier).setCurrentUser;
    final isLoading = useState(true);
    final homeScreen = (isLoading.value)
        ? const Center(child: CircularProgressIndicator())
        : (auth.user == null)
            ? const LoginScreen()
            : (auth.hasProfile == false)
                ? const CreateUser()
                : const HomeScreen();

    Future<void> _init() async {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await EventsApi.init();

      FirebaseAuth.instance.idTokenChanges().listen((User? user) async {
        if (user == null) {
          setCurrentUser(const RenderUser());
          if (isLoading.value) isLoading.value = false;
        } else {
          final renderUser = await RenderUser(user: user).getUserProfile();
          setCurrentUser(renderUser);
          if (isLoading.value) isLoading.value = false;
        }
      });
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
            fontWeight: FontWeight.w500,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xffff88df),
            ),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: homeScreen,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'home':
            return MaterialPageRoute(builder: (context) => const HomeScreen());
          case 'login':
            return MaterialPageRoute(builder: (context) => const LoginScreen());
          case 'create':
            return MaterialPageRoute(builder: (context) => const CreateUser());
          case 'create/professional':
            return MaterialPageRoute(
                builder: (context) => const CreateUserProfessional());
          case 'create/location':
            return MaterialPageRoute(
                builder: (context) => const CreateUserLocation());
          case 'create/profile_pic':
            return MaterialPageRoute(
                builder: (context) => const CreateUserProfilePic());
          case 'profile':
            return MaterialPageRoute(
                builder: (context) => const RenderProfile());
          case 'profile/edit':
            return MaterialPageRoute(
                builder: (context) => const RenderProfileEdit());
          case 'settings':
            return MaterialPageRoute(
                builder: (context) => const RenderSettings());
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
