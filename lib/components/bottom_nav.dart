import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:render/components/coming_soon.dart';

class RenderBottomNav extends StatelessWidget {
  const RenderBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  case 2:
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      isDismissible: true,
                      context: context,
                      isScrollControlled: true,
                      shape: shape,
                      builder: (BuildContext context) {
                        return const RenderComingSoon();
                      },
                    );
                    break;
                  default:
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
