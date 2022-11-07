import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:heroicons/heroicons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:render/components/full_screen_loader.dart';
import 'package:render/models/auth.dart';
import 'package:render/models/events.dart';

class RenderEventFullView extends HookConsumerWidget {
  final RenderEvent? event;
  const RenderEventFullView({super.key, this.event});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fetchEventInfo = ref.read(eventsProvider.notifier).fetchEventInfo;
    final events = ref.watch(eventsProvider);
    final data = events.getEvent(event?.id ?? "");
    final rsvp = ref.read(eventsProvider.notifier).rsvpEvent;
    final userId = ref.read(userProvider).userProfile.id;
    final image =
        "${data?.images?[0].baseUrl}${data?.images?[0].id}/${MediaQuery.of(context).size.width.toInt()}x200.jpg";
    final DateFormat format = DateFormat('E, MMMM d, y');
    final hasRsvp = useState(data?.rsvp != null && data!.rsvp!);
    final isSaving = useState(false);
    final isLoading = useState(true);
    final isAvailable = data?.status != "Sold Out";

    useEffect(() {
      if (data?.id != null && userId != null) {
        fetchEventInfo(eventId: data!.id!, userId: userId).then((value) {
          isLoading.value = false;
        });
      }
      return;
    }, [data?.id, userId, data?.rsvp]);

    return (isLoading.value)
        ? const RenderLoader()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 200,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(left: 16, bottom: 70),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const HeroIcon(
                      HeroIcons.xCircle,
                      solid: true,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          data?.title ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Gothic A1",
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          "Date and Time",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Gothic A1",
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          (data?.dateTime != null)
                              ? format.format(DateTime.parse(data!.dateTime!))
                              : "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Gothic A1",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          "Location",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Gothic A1",
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        child: Text(
                          data?.venue?.address ?? "",
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: "Gothic A1",
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const Text(
                          "About",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Gothic A1",
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      Text(
                        data?.description ?? "",
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: "Gothic A1",
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 30, top: 10),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (isAvailable &&
                        !hasRsvp.value &&
                        userId != null &&
                        data?.recordID != null) {
                      isSaving.value = true;
                      await rsvp(
                        userId: userId,
                        recordId: data!.recordID!,
                        eventId: data.id!,
                      );
                      hasRsvp.value = true;
                      isSaving.value = false;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (hasRsvp.value)
                        ? Colors.black
                        : (!isAvailable)
                            ? const Color(0xff8B8B8B)
                            : const Color(0xffFF88DF),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: (isSaving.value)
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(),
                        )
                      : Text(
                          (hasRsvp.value)
                              ? "You’re all set!"
                              : (!isAvailable)
                                  ? "Sold Out"
                                  : "RSVP",
                          style: TextStyle(
                            fontFamily: "Mortend",
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color:
                                (hasRsvp.value) ? Colors.white : Colors.black,
                          ),
                        ),
                ),
              )
            ],
          );
  }
}
