import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/avatar.dart';
import 'package:render/components/full_screen_loader.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/connections.dart';
import 'package:render/models/user_profile.dart';
import 'package:url_launcher/url_launcher.dart';

class RenderViewConnection extends HookConsumerWidget {
  final RenderConnection user;
  const RenderViewConnection({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final removeConnection =
        ref.read(userProvider.notifier).removeConnectionToUser;
    final fetchUser = ref.read(userProvider.notifier).getUserProfile;
    final profile = useState(const UserProfile());

    void navigateAway() {
      Navigator.pop(context);
    }

    useEffect(() {
      fetchUser(userId: user.id, save: false).then((value) {
        profile.value = value.userProfile;
      });
      return;
    }, [user]);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      height: 500,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      child: (profile.value.id == null)
          ? const RenderLoader()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 40),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset('assets/images/close.png'),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          await removeConnection(user);
                          navigateAway();
                        },
                        child: Image.asset('assets/images/removeUser.png'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  child: RenderAvatar(
                    pictureUrl: user.profile_photo_url,
                    width: 64,
                    height: 64,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    "${user.first_name} ${user.last_name}",
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: "Gothic A1",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                ),
                if (profile.value.website != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: RenderConnectionBtn(
                      label: "Website",
                      url: profile.value.website!,
                    ),
                  ),
                if (profile.value.linkedin_profile != null)
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: RenderConnectionBtn(
                      label: "LinkedIn",
                      url: profile.value.linkedin_profile!,
                    ),
                  )
              ],
            ),
    );
  }
}

class RenderConnectionBtn extends StatelessWidget {
  final String label;
  final String url;

  const RenderConnectionBtn({
    Key? key,
    this.label = "",
    this.url = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        late Uri launchUri = Uri.parse(url);

        if (!launchUri.hasScheme) {
          launchUri = Uri.parse("http://$url");
        }

        if (await canLaunchUrl(launchUri)) {
          await launchUrl(launchUri);
        }
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.black),
        ),
        alignment: Alignment.center,
        child: Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "Mortend",
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
