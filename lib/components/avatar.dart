import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/models/auth.dart';

class RenderAvatar extends HookConsumerWidget {
  final double? width;
  final double? height;
  final double? fontSize;
  final bool? showEdit;
  final bool? isLoading;

  const RenderAvatar({
    Key? key,
    this.width,
    this.height,
    this.fontSize,
    this.showEdit,
    this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userProfile;
    final hasImage =
        user.profile_photo_url != null && user.profile_photo_url!.isNotEmpty;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            foregroundImage:
                (hasImage) ? NetworkImage(user.profile_photo_url!) : null,
            child: (hasImage)
                ? null
                : Center(
                    child: Text(
                      "${user.first_name?[0]}${user.last_name?[0]}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: fontSize ?? 12,
                      ),
                    ),
                  ),
          ),
        ),
        if (showEdit ?? false) Image.asset('assets/images/camera.png'),
        if (isLoading ?? false) const CircularProgressIndicator(),
      ],
    );
  }
}
