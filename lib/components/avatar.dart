import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/models/auth.dart';

class RenderAvatar extends HookConsumerWidget {
  final double? width;
  final double? height;
  final double? fontSize;
  final bool? showEdit;
  final bool? isLoading;
  final String? pictureUrl;

  const RenderAvatar({
    Key? key,
    this.width,
    this.height,
    this.fontSize,
    this.showEdit,
    this.isLoading,
    this.pictureUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).userProfile;
    final hasImage = (pictureUrl != null) ||
        user.profile_photo_url != null && user.profile_photo_url!.isNotEmpty;
    final image = (pictureUrl != null) ? pictureUrl : user.profile_photo_url;

    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: width,
          height: height,
          child: CircleAvatar(
            backgroundColor: Colors.brown.shade800,
            foregroundImage: (hasImage) ? NetworkImage(image!) : null,
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
