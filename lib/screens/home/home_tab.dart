import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:render/components/full_screen_loader.dart';
import 'package:render/models/events.dart';
import 'package:render/screens/home/eventcard.dart';

class HomeTab extends HookConsumerWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(eventsProvider);
    final fetchEvents = ref.read(eventsProvider.notifier).fetchEvents;
    final events = state.listEvents();
    final isLoading = useState(true);

    useEffect(() {
      fetchEvents().then((value) {
        isLoading.value = false;
      });
      return;
    }, []);

    return (isLoading.value)
        ? const RenderLoader()
        : SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 20),
                  child: const Text(
                    'Upcoming Events',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Gothic A1',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: events.length,
                  itemBuilder: (BuildContext context, int index) {
                    final event = events.elementAt(index);
                    return RenderEventCard(event: event!);
                  },
                )
              ],
            ),
          );
  }
}
