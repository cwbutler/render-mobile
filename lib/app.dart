import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:render/amplify.dart';
import 'package:render/auth_model.dart';
// Pages (Screens)
import 'package:render/home.dart';
import 'package:render/login.dart';

class RenderApp extends HookWidget {
  const RenderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Default status bar to 'light'
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final user = useState(AuthUser(userId: "", username: ""));
    final isLoading = useState(true);

    Future<void> _init() async {
      await RenderAmplify.configure();
      final result = await AuthModel.getCurrentUser();
      if (result.userId.isNotEmpty) {
        user.value = result;
      }
      isLoading.value = false;
    }

    useEffect(() {
      _init();
      return null;
    }, []);

    return MaterialApp(
      title: 'Render Conference App',
      theme:
          ThemeData(primarySwatch: Colors.amber, backgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: (isLoading.value)
          ? const Center(child: CircularProgressIndicator())
          : (user.value.userId.isEmpty)
              ? const LoginScreen()
              : const HomeScreen(),
      onGenerateRoute: (settings) {
        debugPrint("${user.value.userId.isEmpty} ${settings.name}");

        switch (settings.name) {
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
