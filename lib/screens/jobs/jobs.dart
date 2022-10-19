import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/models/jobs.dart';
import 'package:render/screens/jobs/job.dart';

class RenderJobScreen extends HookConsumerWidget {
  const RenderJobScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobsProvider);
    final fetchJobs = ref.read(jobsProvider.notifier).fetchJobs;
    final jobs = state.listJobs();

    useEffect(() {
      fetchJobs();
      return;
    }, []);

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: jobs.length,
            itemBuilder: (BuildContext context, int index) {
              return RenderJobSummary(
                job: jobs.elementAt(index)!,
              );
            },
          ),
        )
      ],
    );
  }
}
