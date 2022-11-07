import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/user_profile.dart';

const List<String> jobInterest = <String>[
  'Please Select',
  'Front End Role',
  'Back End Role',
  'Manager Role',
  'Support Role',
  'Designer Role',
  'Other',
];

class RenderPicker extends HookConsumerWidget {
  const RenderPicker({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userProfile;
    final updateUser = ref.read(userProvider.notifier).updateUserProfile;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Job Interest",
          style: TextStyle(
            color: Color(0xffff88df),
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        CupertinoButton(
          padding: const EdgeInsets.all(0),
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (BuildContext context) => Container(
                height: 216,
                padding: const EdgeInsets.only(top: 6.0),
                // The Bottom margin is provided to align the popup above the system navigation bar.
                margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                // Provide a background color for the popup.
                color: Colors.black,
                // Use a SafeArea widget to avoid system overlaps.
                child: SafeArea(
                  top: false,
                  child: CupertinoPicker(
                    itemExtent: 32,
                    onSelectedItemChanged: (int selectedItem) {
                      updateUser(
                        UserProfile(
                          job_interest: (selectedItem > 0)
                              ? jobInterest[selectedItem]
                              : null,
                        ),
                      );
                    },
                    children: List<Widget>.generate(
                      jobInterest.length,
                      (int index) {
                        return Center(
                          child: Text(
                            jobInterest[index],
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            );
          },
          child: Text(
            user.job_interest ?? jobInterest[0],
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
