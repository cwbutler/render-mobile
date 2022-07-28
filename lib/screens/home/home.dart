import 'package:flutter/material.dart';
import 'package:render/components/app_bar.dart';
import 'package:render/components/bottom_nav.dart';
import 'package:render/screens/home/home_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: const RenderAppBar(),
          bottomNavigationBar: const RenderBottomNav(),
          body: Container(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: const TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                HomeTab(),
                Icon(Icons.directions_transit),
                Icon(Icons.directions_bike),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
