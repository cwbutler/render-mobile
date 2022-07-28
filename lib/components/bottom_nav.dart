import 'package:flutter/material.dart';
import 'package:render/components/coming_soon.dart';

class RenderBottomNav extends StatelessWidget {
  const RenderBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      child: Material(
          color: const Color(0xff262626),
          borderRadius: const BorderRadius.all(Radius.circular(100)),
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
                  icon: Icon(Icons.file_open),
                  label: "Job Boards",
                ),
              ],
            ),
          )),
    );
  }
}
