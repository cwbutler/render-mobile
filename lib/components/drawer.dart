import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/auth_model.dart';
import 'package:render/models/user.dart';

class RenderDrawer extends HookConsumerWidget {
  const RenderDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clearUser = ref.read(userProvider.notifier).clearUser;

    return SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
            backgroundColor: Colors.black,
            child: SafeArea(
              child: Column(children: <Widget>[
                // Header
                const RenderDrawerHeader(),
                // Body
                Expanded(child: ListView()),
                // Logout
                TextButton(
                    onPressed: () {
                      AuthModel.logout()
                          .then((value) => {if (value) clearUser()});
                    },
                    child: const Text("LOGOUT",
                        style: TextStyle(
                            color: Colors.amber,
                            fontFamily: 'Mortend',
                            fontSize: 20)))
              ]),
            )));
  }
}

class RenderDrawerHeader extends StatelessWidget {
  const RenderDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(children: [
        Container(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: SvgPicture.asset('assets/svgs/close_btn.svg'),
            onPressed: () => Scaffold.of(context).closeDrawer(),
          ),
        ),
        Container(
          alignment: Alignment.center,
          height: 47,
          child: const Text("Settings",
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Gothic A1',
                  fontWeight: FontWeight.bold,
                  fontSize: 20)),
        )
      ]),
    );
  }
}
