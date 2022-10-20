import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:render/models/events.dart';

class RenderEventFullView extends StatelessWidget {
  final RenderEvent? event;
  const RenderEventFullView({super.key, this.event});

  @override
  Widget build(BuildContext context) {
    final image =
        "${event?.images?[0].baseUrl}${event?.images?[0].id}/${MediaQuery.of(context).size.width.toInt()}x200.jpg";
    final DateFormat format = DateFormat('E, MMMM d, y');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(image),
              fit: BoxFit.cover,
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
                    event?.title ?? "",
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
                    (event?.dateTime != null)
                        ? format.format(DateTime.parse(event!.dateTime!))
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
                    event?.venue?.address ?? "",
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
                  event?.description ?? "",
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
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 10),
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xffFF88DF),
              padding: const EdgeInsets.all(20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: const Text(
              "RSVP",
              style: TextStyle(
                fontFamily: "Mortend",
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        )
      ],
    );
  }
}
