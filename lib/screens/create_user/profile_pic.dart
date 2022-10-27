import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/models/user_profile.dart';
import 'package:render/screens/create_user/layout.dart';
import 'package:render/screens/create_user/next_button.dart';
import 'package:render/models/auth.dart';
//import 'package:render/models/user.dart';

class CreateUserProfilePic extends HookConsumerWidget {
  const CreateUserProfilePic({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(userProvider);
    final user = appUser.userProfile;
    final updateUser = ref.read(userProvider.notifier).updateUserProfile;
    final saveImage = ref.read(userProvider.notifier).saveUserImage;
    final photoUrl = user.profile_photo_url ?? '';
    final borderColor =
        (photoUrl.isEmpty) ? Colors.white : const Color(0xffFF88DF);
    final isLoading = useState(false);

    navigateHome() {
      Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    }

    onNext() async {
      NotificationSettings settings =
          await FirebaseMessaging.instance.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
      final fcmToken = await FirebaseMessaging.instance.getToken();
      await updateUser(
        UserProfile(
          isNotificationsEnabled:
              settings.authorizationStatus == AuthorizationStatus.authorized,
          fcmToken: fcmToken,
        ),
      ).saveUserProfile();
      navigateHome();
    }

    return CreateUserLayout(
      active: 4,
      title: 'PROFILE PIC',
      subtitle: "Add a profile picture...or don’t",
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                type: FileType.image,
              );
              if (result != null && result.files.first.path != null) {
                PlatformFile file = result.files.first;
                File fileData = File(file.path!);
                isLoading.value = true;
                await saveImage(file: fileData);
                isLoading.value = false;
              } else {
                // User canceled the picker
              }
            },
            child: CircleAvatar(
              backgroundColor: borderColor,
              radius: 53,
              child: (isLoading.value)
                  ? const Center(child: CircularProgressIndicator())
                  : CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color.fromRGBO(255, 136, 223, 1),
                      foregroundImage: (user.profile_photo_url != null)
                          ? NetworkImage(user.profile_photo_url!)
                          : null,
                      child: (user.profile_photo_url == null)
                          ? SvgPicture.asset("assets/svgs/camera.svg")
                          : null,
                    ),
            ),
          ),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(top: 50),
            child: NextButton(onPressed: onNext, title: 'FINISH'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            child: TextButton(
              onPressed: onNext,
              child: const Text(
                'Add later',
                style: TextStyle(
                  color: Color(0xffFF88DF),
                  fontFamily: 'Gothic A1',
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
