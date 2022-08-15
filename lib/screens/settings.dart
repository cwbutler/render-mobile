import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/menu_appbar.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/user_profile.dart';
import 'package:render/components/confirm_delete.dart';

class RenderSettings extends HookConsumerWidget {
  const RenderSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userProfile;
    final updateUser = ref.read(userProvider.notifier).updateUserProfile;
    final deleteUser = ref.read(userProvider.notifier).deleteUser;
    const labelStyle = TextStyle(
      color: Colors.white,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );

    void navigateHome() {
      Navigator.pushNamedAndRemoveUntil(context, "login", (route) => false);
    }

    void onDelete() async {
      await deleteUser();
      navigateHome();
    }

    return Scaffold(
      appBar: const RenderMenuAppBar(title: "Settings"),
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30, top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Notifications", style: labelStyle),
                  const Spacer(),
                  CupertinoSwitch(
                    value: user.isNotificationsEnabled ?? false,
                    onChanged: (value) async {
                      await updateUser(
                        UserProfile(isNotificationsEnabled: value),
                      ).saveUserProfile();
                    },
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'terms');
                },
                child: const Text("Terms and Conditions", style: labelStyle),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'privacy');
                },
                child: const Text("Privacy Policy", style: labelStyle),
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.only(bottom: 60),
              child: TextButton(
                onPressed: () {
                  showModalBottomSheet(
                    isDismissible: true,
                    context: context,
                    backgroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    builder: (BuildContext context) {
                      return RenderConfirm(
                        title: "Delete your account?",
                        subtitle:
                            "Are you sure want to delete your Render account?",
                        confirm: "DELETE",
                        onConfirm: onDelete,
                      );
                    },
                  );
                },
                child: const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "DELETE ACCOUNT",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffEA4335),
                      fontFamily: 'Mortend',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
