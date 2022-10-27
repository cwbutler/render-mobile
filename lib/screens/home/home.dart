import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/app_bar.dart';
import 'package:render/components/bottom_nav.dart';
import 'package:render/screens/connections/connections.dart';
import 'package:render/screens/home/home_tab.dart';
import 'package:render/screens/jobs/jobs.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = useState(0);

    const screens = [
      HomeTab(),
      RenderConnectionsScreen(),
      RenderJobScreen(),
    ];

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: const RenderAppBar(),
          bottomNavigationBar: RenderBottomNav(
            currentIndex: currentIndex.value,
            setIndex: (index) => currentIndex.value = index,
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
            child: screens[currentIndex.value],
          ),
        ),
      ),
    );
  }
}
