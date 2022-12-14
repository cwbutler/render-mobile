import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/avatar.dart';
import 'package:render/components/job_picker.dart';
import 'package:render/components/menu_appbar.dart';
import 'package:render/components/phone_input.dart';
import 'package:render/models/app.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/user_profile.dart';
import 'package:render/components/input.dart';
import 'package:render/screens/create_user/next_button.dart';
import 'package:render/components/resume.dart';

class RenderProfileEdit extends HookConsumerWidget {
  const RenderProfileEdit({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(userProvider);
    final user = ref.watch(userProvider).userProfile;
    final updateUser = ref.read(userProvider.notifier).updateUserProfile;
    final saveImage = ref.read(userProvider.notifier).saveUserImage;
    final isImgLoading = useState(false);
    final isUserLoading = useState(false);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const RenderMenuAppBar(title: "Edit Profile"),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: RenderAvatar(
                    width: 72,
                    height: 72,
                    showEdit: true,
                    isLoading: isImgLoading.value,
                  ),
                ),
                // Edit Profile
                Container(
                  margin: const EdgeInsets.only(bottom: 38),
                  child: TextButton(
                    onPressed: () async {
                      final file = await RenderAppModel.getImageFromDevice();
                      if (file != null) {
                        isImgLoading.value = true;
                        await saveImage(file: file);
                        isImgLoading.value = false;
                      }
                    },
                    child: Text(
                      "Change Profile Picture",
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                CreateInput(
                  label: "Name",
                  initalText: "${user.first_name} ${user.last_name}",
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  onChange: (value) {
                    final values = value.split(" ");
                    final firstName = values[0];
                    values.removeAt(0);
                    final lastName = values.join(" ");

                    updateUser(
                      UserProfile(first_name: firstName, last_name: lastName),
                    );
                  },
                ),
                CreateInput(
                  label: "Email",
                  initalText: user.email,
                  keyboardType: TextInputType.emailAddress,
                  onChange: (value) {
                    updateUser(UserProfile(email: value));
                  },
                ),
                RenderPhoneInput(
                  label: "Phone",
                  initialText: user.phone,
                  onChange: (value) {
                    updateUser(UserProfile(phone: value));
                  },
                ),
                CreateInput(
                  label: "Website",
                  initalText: user.website,
                  keyboardType: TextInputType.url,
                  onChange: (value) {
                    updateUser(UserProfile(website: value));
                  },
                ),
                CreateInput(
                  label: "LinkedIn",
                  initalText: user.linkedin_profile,
                  keyboardType: TextInputType.url,
                  onChange: (value) {
                    updateUser(UserProfile(linkedin_profile: value));
                  },
                ),
                CreateInput(
                  label: "Location",
                  initalText: user.location,
                  keyboardType: TextInputType.number,
                  onChange: (value) {
                    updateUser(UserProfile(location: value));
                  },
                ),
                const RenderResumeInput(),
                Container(
                  margin: const EdgeInsets.only(top: 25),
                  width: double.infinity,
                  child: const RenderPicker(),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 30),
                  child: NextButton(
                    title: "Save",
                    isLoading: isUserLoading.value,
                    onPressed: () async {
                      isUserLoading.value = true;
                      await appUser.saveUserProfile();
                      isUserLoading.value = false;
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
