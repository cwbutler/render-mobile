import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/webview.dart';
import 'package:render/landing.dart';
import 'package:render/models/auth.dart';
import 'package:render/screens/jobs/jobs.dart';
import 'package:render/screens/profile/edit.dart';
import 'package:render/screens/profile/profile.dart';
import 'package:render/screens/settings.dart';

// Pages (Screens)
import 'package:render/screens/home/home.dart';
import 'package:render/screens/login/login.dart';
import 'package:render/screens/create_user/create_user.dart';
import 'package:render/screens/create_user/professional.dart';
import 'package:render/screens/create_user/location.dart';
import 'package:render/screens/create_user/profile_pic.dart';
import 'package:render/screens/unknown.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RenderApp extends HookConsumerWidget {
  const RenderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userProfile;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return MaterialApp(
      title: 'Render Conference App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xffff88df),
        backgroundColor: Colors.black,
        fontFamily: 'Gothic A1',
        disabledColor: Colors.black,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
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
      home: const RenderAppLanding(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'home':
            return MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            );
          case 'login':
            return MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            );
          case 'create':
            return MaterialPageRoute(
              builder: (context) => const CreateUser(),
            );
          case 'create/professional':
            return MaterialPageRoute(
              builder: (context) => const CreateUserProfessional(),
            );
          case 'create/location':
            return MaterialPageRoute(
              builder: (context) => const CreateUserLocation(),
            );
          case 'create/profile_pic':
            return MaterialPageRoute(
              builder: (context) => const CreateUserProfilePic(),
            );
          case 'profile':
            return MaterialPageRoute(
              builder: (context) => const RenderProfile(),
            );
          case 'profile/edit':
            return MaterialPageRoute(
              builder: (context) => const RenderProfileEdit(),
            );
          case 'settings':
            return MaterialPageRoute(
              builder: (context) => const RenderSettings(),
            );
          case 'podcast':
            return MaterialPageRoute(
              builder: (context) => const RenderWebView(
                url: "https://anchor.fm/renderatl",
              ),
            );
          case 'discord':
            return MaterialPageRoute(
              builder: (context) => const RenderWebView(
                url: "https://renderatl.com/discord",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            );
          case 'merch':
            return MaterialPageRoute(
              builder: (context) => const RenderWebView(
                url: "https://renderhardwear.com",
              ),
            );
          case 'buyTickets':
            return MaterialPageRoute(
              builder: (context) => RenderWebView(
                url: "https://ti.to/render-atlanta/2023/discount/${user.email}",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            );
          case 'privacy':
            return MaterialPageRoute(
              builder: (context) => const RenderWebView(
                url: "https://renderatl.com/privacy",
                javascriptMode: JavascriptMode.unrestricted,
              ),
            );
          case 'terms':
            return MaterialPageRoute(
              builder: (context) => const RenderWebView(
                url: "https://renderatl.com/terms",
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const UnknownScreen(),
            );
        }
      },
    );
  }
}
