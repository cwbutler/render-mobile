import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/avatar.dart';
import 'package:render/components/full_screen_loader.dart';
import 'package:render/models/auth.dart';

class RenderConnectToUser extends HookConsumerWidget {
  final String userId;
  const RenderConnectToUser({super.key, required this.userId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = useState(const RenderUser());
    final isConnecting = useState(false);
    final getUser = ref.read(userProvider.notifier).getUserProfile;
    final connect = ref.read(userProvider.notifier).connectToUser;

    void navigateAway() {
      Navigator.pop(context);
    }

    useEffect(() {
      getUser(userId: userId, save: false).then((value) {
        user.value = value;
      });
      return;
    }, []);

    void onConnect() async {
      isConnecting.value = true;
      await connect(user.value.userProfile);
      navigateAway();
    }

    return (user.value.userProfile.id == null)
        ? const RenderLoader()
        : Container(
            padding: const EdgeInsets.all(40),
            height: 500,
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 26),
                  child: RenderAvatar(
                    width: 154,
                    height: 154,
                    pictureUrl: user.value.userProfile.profile_photo_url,
                  ),
                ),
                Text(
                  "${user.value.userProfile.first_name} ${user.value.userProfile.last_name}"
                      .toUpperCase(),
                  style: const TextStyle(
                    fontFamily: "Mortend",
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: onConnect,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side:
                              const BorderSide(width: 1, color: Colors.black)),
                      padding: const EdgeInsets.all(16),
                      backgroundColor: Colors.white,
                    ),
                    child: (isConnecting.value)
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              color: Color(0xffff88df),
                            ),
                          )
                        : const Text(
                            "CONNECT",
                            style: TextStyle(
                              fontFamily: "Mortend",
                              fontSize: 22,
                              color: Colors.black,
                            ),
                          ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "CANCEL",
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: "Mortend",
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
