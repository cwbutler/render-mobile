import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:render/components/drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Builder(
          builder: (context) => IconButton(
            icon: SvgPicture.asset('assets/svgs/logo.svg'),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/svgs/notifications.svg'),
            onPressed: () => {},
          ),
          IconButton(
            icon: CircleAvatar(
              backgroundColor: Colors.brown.shade800,
              child: const Text('AH'),
            ),
            onPressed: () => {},
          )
        ],
      ),
      drawer: Builder(builder: (context) => const RenderDrawer()),
      body: Container(
          margin: const EdgeInsets.only(bottom: 165),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset('assets/images/logo.png'),
                const Center(
                    child: Text(
                  'Coming Soon',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontFamily: 'Gothic A1'),
                ))
              ])),
    );
  }
}
