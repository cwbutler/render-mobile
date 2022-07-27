import 'package:flutter/material.dart';

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
            child: const TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Color(0xffFF88DF),
              indicator: BoxDecoration(),
              tabs: [
                Tab(
                  icon: RenderTabIcon(
                    icon: Icon(Icons.home),
                    label: "Home",
                  ),
                ),
                Tab(
                  icon: RenderTabIcon(
                    icon: Icon(Icons.person_add),
                    label: "Connections",
                  ),
                ),
                Tab(
                  icon: RenderTabIcon(
                    icon: Icon(Icons.file_open),
                    label: "Job Boards",
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

class RenderTabIcon extends StatelessWidget {
  final Widget? icon;
  final String? label;
  const RenderTabIcon({Key? key, this.icon, this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) icon!,
        if (label != null)
          Container(
            margin: const EdgeInsets.symmetric(vertical: 3),
            child: Text(
              label!,
              style: const TextStyle(fontFamily: 'Inter', fontSize: 10),
            ),
          )
      ],
    );
  }
}
