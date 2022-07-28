import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:file_picker/file_picker.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/user_profile.dart';

class RenderResumeInput extends HookConsumerWidget {
  const RenderResumeInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final updateUser = ref.read(userProvider.notifier).updateUserProfile;
    final isActive = user.userProfile.resume_url?.isNotEmpty ?? false;
    final isLoading = useState(false);

    onPressed() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ["pdf"],
      );
      if (result != null && result.files.first.path != null) {
        PlatformFile file = result.files.first;
        File fileData = File(file.path!);
        isLoading.value = true;
        final url = await user.saveUserResume(
          fileName: file.name,
          file: fileData,
        );
        updateUser(UserProfile(resume_name: file.name, resume_url: url));
        isLoading.value = false;
      } else {
        // User canceled the picker
        debugPrint(result?.files.first.size.toString());
      }
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: const Text(
              "Resume",
              style: TextStyle(
                fontFamily: "Gothic A1",
                fontSize: 16,
                color: Color(0xff8B8B8B),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(65),
              primary: (isActive)
                  ? const Color.fromRGBO(255, 136, 223, 0.6)
                  : Colors.black,
              padding: const EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: (isActive)
                      ? Theme.of(context).primaryColor
                      : const Color(0xff8B8B8B),
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Row(
              mainAxisAlignment: (isActive)
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.center,
              children: (isLoading.value)
                  ? [
                      const Center(
                        child: CircularProgressIndicator(),
                      )
                    ]
                  : (isActive)
                      ? [
                          Text(
                            user.userProfile.resume_name!,
                            maxLines: 1,
                            softWrap: false,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            splashRadius: 10,
                            onPressed: () {
                              updateUser(const UserProfile(
                                resume_name: "",
                                resume_url: "",
                              ));
                            },
                            icon: const Icon(Icons.cancel),
                          )
                        ]
                      : [
                          const Icon(
                            Icons.attach_file,
                            color: Color(0xffDADADA),
                          ),
                          Text(
                            "Attach a file",
                            style: TextStyle(
                              color: (isActive)
                                  ? Colors.black
                                  : const Color(0xffDADADA),
                            ),
                          )
                        ],
            ),
          ),
        ],
      ),
    );
  }
}
