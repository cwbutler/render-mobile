import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final photoUrl = user.profile_photo_url ?? '';
    final borderColor =
        (photoUrl.isEmpty) ? Colors.white : const Color(0xffFF88DF);
    final isLoading = useState(false);

    navigateHome() {
      Navigator.pushNamed(context, 'home');
    }

    onNext() async {
      await appUser.saveUserProfile();
      navigateHome();
    }

    onSkip() async {
      await appUser.saveUserProfile();
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
                final url = await appUser.saveUserImage(file: fileData);
                updateUser(UserProfile(profile_photo_url: url));
                isLoading.value = false;
              } else {
                // User canceled the picker
                debugPrint(result?.files.first.size.toString());
              }
            },
            child: CircleAvatar(
              backgroundColor: borderColor,
              radius: 53,
              child: (isLoading.value)
                  ? const Center(child: CircularProgressIndicator())
                  : CircleAvatar(
                      radius: 50,
                      backgroundColor: const Color(0xffFF88DF),
                      backgroundImage:
                          NetworkImage(user.profile_photo_url ?? ''),
                    ),
            ),
          ),
          const Spacer(),
          Container(
              margin: const EdgeInsets.only(top: 50),
              child: NextButton(onPressed: onNext, title: 'FINISH')),
          Container(
              margin: const EdgeInsets.only(top: 15),
              child: TextButton(
                onPressed: onSkip,
                child: const Text('Add later',
                    style: TextStyle(
                        color: Color(0xffFF88DF),
                        fontFamily: 'Gothic A1',
                        fontWeight: FontWeight.w700,
                        fontSize: 20)),
              ))
        ],
      ),
    );
  }
}
