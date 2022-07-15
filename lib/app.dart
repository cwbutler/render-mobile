import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/amplify.dart';
import 'package:render/auth_model.dart';
import 'package:render/models/user.dart';
// Pages (Screens)
import 'package:render/home.dart';
import 'package:render/login.dart';

class RenderApp extends HookConsumerWidget {
  const RenderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Default status bar to 'light'
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    final user = ref.watch(userProvider);
    final setCurrentUser = ref.read(userProvider.notifier).setCurrentUser;
    final isLoading = useState(true);
    final userId = user.authUser?.userId ?? '';

    Future<void> _init() async {
      await RenderAmplify.configure();
      final authUser = await AuthModel.getCurrentUser();
      if (authUser.userId.isNotEmpty) {
        setCurrentUser(RenderUser(authUser: authUser));
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
          : (userId.isEmpty)
              ? const LoginScreen()
              : const HomeScreen(),
      onGenerateRoute: (settings) {
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
