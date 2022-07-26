import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/drawer.dart';
import 'package:render/models/auth.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userProfile;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: SvgPicture.asset('assets/svgs/logo.svg'),
          onPressed: () => {},
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset('assets/svgs/notifications.svg'),
            onPressed: () => {},
          ),
          Builder(
              builder: (context) => IconButton(
                    icon: CircleAvatar(
                      backgroundColor: Colors.brown.shade800,
                      backgroundImage:
                          NetworkImage(user.profile_photo_url ?? ''),
                    ),
                    onPressed: () => Scaffold.of(context).openDrawer(),
                  )),
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
