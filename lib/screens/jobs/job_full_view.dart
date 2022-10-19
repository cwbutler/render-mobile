import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:render/models/app.dart';
import 'package:render/models/jobs.dart';
import 'package:url_launcher/url_launcher.dart';

class RenderJobFullView extends StatelessWidget {
  final RenderJob? job;
  const RenderJobFullView({super.key, this.job});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.92,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const HeroIcon(
                  HeroIcons.x,
                  color: Colors.black,
                ),
              ),
              const Spacer(),
              Text(
                RenderAppModel.daysBetween(
                  DateTime.parse(job?.createdAt ?? ""),
                  DateTime.now(),
                ),
                style: const TextStyle(
                  color: Color(0xff818181),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              )
            ],
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              job?.title ?? "",
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: const HeroIcon(
                    HeroIcons.briefcase,
                    size: 14,
                    color: Colors.black,
                  ),
                ),
                Text(
                  job?.org ?? "",
                  style: const TextStyle(color: Colors.black, fontSize: 14),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(
                job?.summary ?? "",
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                final Uri launchUri = Uri.parse(job?.url ?? "");
                if (await canLaunchUrl(launchUri)) {
                  await launchUrl(launchUri);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffFF88DF),
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              child: const Text(
                "Apply",
                style: TextStyle(
                  fontFamily: "Mortend",
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
