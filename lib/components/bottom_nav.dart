import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/coming_soon.dart';

class RenderBottomNav extends HookConsumerWidget {
  final int? currentIndex;
  final void Function(int index)? setIndex;

  const RenderBottomNav({
    Key? key,
    this.currentIndex,
    this.setIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Material(
          color: const Color.fromRGBO(0, 0, 0, 0.85),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: BottomNavigationBar(
              backgroundColor: Colors.transparent,
              unselectedItemColor: Colors.white,
              selectedItemColor: const Color(0xffFF88DF),
              currentIndex: currentIndex ?? 0,
              onTap: (int index) {
                const shape = RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                );
                switch (index) {
                  case 1:
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      isDismissible: true,
                      isScrollControlled: true,
                      context: context,
                      shape: shape,
                      builder: (BuildContext context) {
                        return const RenderComingSoon();
                      },
                    );
                    break;
                  default:
                    if (setIndex != null) setIndex!(index);
                    break;
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: "Home",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_add_alt_1),
                  label: "Connections",
                ),
                BottomNavigationBarItem(
                  icon: HeroIcon(
                    HeroIcons.collection,
                    solid: true,
                  ),
                  label: "Job Boards",
                ),
              ],
            ),
          )),
    );
  }
}
