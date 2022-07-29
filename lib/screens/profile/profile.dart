import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/avatar.dart';
import 'package:render/models/auth.dart';
import 'package:render/screens/profile/value_field.dart';

class RenderProfile extends HookConsumerWidget {
  const RenderProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userProfile;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: const RenderAvatar(
                  width: 72,
                  height: 72,
                ),
              ),
              // Edit Profile
              Container(
                margin: const EdgeInsets.only(bottom: 38),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Edit Profile",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
              RenderProfileField(
                label: "Name",
                value: "${user.first_name} ${user.last_name}",
              ),
              RenderProfileField(
                label: "Email",
                value: user.email,
              ),
              RenderProfileField(
                label: "Website",
                value: user.website,
              ),
              RenderProfileField(
                label: "Resume",
                value: user.resume_name,
                isActive: true,
              ),
              RenderProfileField(
                label: "LinkedIn",
                value: user.linkedin_profile,
              ),
              RenderProfileField(
                label: "Phone",
                value: user.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
