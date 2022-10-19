import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:render/models/app.dart';
import 'package:render/models/jobs.dart';
import 'package:render/screens/jobs/job_full_view.dart';

class RenderJobSummary extends StatelessWidget {
  final RenderJob job;
  const RenderJobSummary({super.key, this.job = const RenderJob()});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) {
            return RenderJobFullView(job: job);
          },
        );
      },
      child: Container(
        height: 100,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xff1b1b1b),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: Text(
                        job.title ?? "",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: const HeroIcon(HeroIcons.briefcase, size: 14),
                      ),
                      Text(
                        job.org ?? "",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      )
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 24),
              child: Text(
                RenderAppModel.daysBetween(
                    DateTime.parse(job.createdAt ?? ""), DateTime.now()),
                style: const TextStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
