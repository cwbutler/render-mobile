import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/drawer.dart';
import 'package:render/models/auth.dart';
import 'package:render/screens/home/home_tab.dart';

class TabIcon extends StatelessWidget {
  final Widget? icon;
  final String? label;
  const TabIcon({Key? key, this.icon, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) icon!,
        if (label != null)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            child: Text(
              label!,
              style: const TextStyle(fontFamily: 'Inter', fontSize: 10),
            ),
          )
      ],
    );
  }
}

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userProfile;

    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
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
                    backgroundImage: NetworkImage(user.profile_photo_url ?? ''),
                  ),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
            ],
          ),
          drawer: Builder(builder: (context) => const RenderDrawer()),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
            child: Material(
                color: const Color(0xff262626),
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: const TabBar(
                    unselectedLabelColor: Colors.white,
                    labelColor: Color(0xffFF88DF),
                    indicator: BoxDecoration(),
                    tabs: [
                      Tab(
                        icon: TabIcon(
                          icon: Icon(Icons.home),
                          label: "Home",
                        ),
                      ),
                      Tab(
                        icon: TabIcon(
                          icon: Icon(Icons.person_add),
                          label: "Connections",
                        ),
                      ),
                      Tab(
                        icon: TabIcon(
                          icon: Icon(Icons.file_open),
                          label: "Job Boards",
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          body: Container(
            padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
            child: const TabBarView(
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
