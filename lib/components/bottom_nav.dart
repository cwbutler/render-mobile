import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                switch (index) {
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
