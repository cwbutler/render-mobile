import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:render/models/events.dart';
import 'package:render/screens/home/event_full_view.dart';

class RenderEventCard extends StatelessWidget {
  final RenderEvent event;

  const RenderEventCard({Key? key, required this.event}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final date = DateTime.parse(event.dateTime ?? "");
    final image =
        "${event.images?[0].baseUrl}${event.images?[0].id}/${MediaQuery.of(context).size.width.toInt()}x140.jpg";
    const textStyle = TextStyle(
      fontFamily: 'Inter',
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.w800,
    );

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          builder: (context) {
            return RenderEventFullView(event: event);
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: 140,
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.73),
              BlendMode.dstATop,
            ),
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              child: Column(
                children: [
                  Text(
                    date.day.toString().padLeft(2, "0"),
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    getMonth(date.month),
                    style: textStyle,
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.title ?? "",
                    style: textStyle,
                  ),
                  Row(children: [
                    Container(
                      margin: const EdgeInsets.only(right: 4),
                      child: SvgPicture.asset("assets/svgs/location.svg"),
                    ),
                    Text(
                      "${event.venue?.city}, ${event.venue?.state}",
                      style: textStyle,
                    )
                  ])
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String getMonth(int month) {
  switch (month) {
    case DateTime.january:
      return "Jan";
    case DateTime.february:
      return "Feb";
    case DateTime.march:
      return "March";
    case DateTime.april:
      return "April";
    case DateTime.may:
      return "May";
    case DateTime.june:
      return "June";
    case DateTime.july:
      return "July";
    case DateTime.august:
      return "Aug";
    case DateTime.september:
      return "Sept";
    case DateTime.october:
      return "Oct";
    case DateTime.november:
      return "Nov";
    case DateTime.december:
      return "Dece";
    default:
      return "";
  }
}
