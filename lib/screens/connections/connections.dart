import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/avatar.dart';
import 'package:render/components/full_screen_loader.dart';
import 'package:render/components/view_connection.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/connections.dart';

class RenderConnectionsScreen extends HookConsumerWidget {
  const RenderConnectionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchConnections = ref.read(userProvider.notifier).getUserConnections;
    final connections = ref.watch(userProvider).connections;
    final isLoading = useState(true);

    useEffect(() {
      fetchConnections().then((value) {
        isLoading.value = false;
      });
      return;
    }, []);

    return (isLoading.value)
        ? const RenderLoader()
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 24),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(right: 8),
                      child: const Text(
                        "My Connections",
                        style: TextStyle(
                          fontFamily: "Gothic A1",
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Text(
                      "(${connections.ids.length})",
                      style: const TextStyle(
                        fontFamily: "Gothic A1",
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff575757),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: connections.ids.length,
                  itemBuilder: ((context, index) {
                    final id = connections.ids[index];
                    final user =
                        connections.entities[id] ?? const RenderConnection();
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          builder: ((context) {
                            return RenderViewConnection(user: user);
                          }),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 16),
                              child: RenderAvatar(
                                pictureUrl: user.profile_photo_url,
                              ),
                            ),
                            Text(
                              "${user.first_name} ${user.last_name}",
                              style: const TextStyle(
                                fontFamily: "Gothic A1",
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ),
              )
            ],
          );
  }
}
