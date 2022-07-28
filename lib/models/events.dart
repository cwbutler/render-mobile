// ignore_for_file: non_constant_identifier_names

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EventsApi {
  static JWT? jwt;
  static bool? isLoaded = false;

  EventsApi();

  static void init() async {
    jwt = JWT(
      {},
      subject: "",
    );
    isLoaded = true;
  }

  static List<RenderEvent> fetchEvents() {
    return [
      RenderEvent(
        title: "Black Tech Haus",
        dateTime: DateTime.utc(2022, DateTime.may, 20).toIso8601String(),
        images: const [
          RenderEventImage(
            id: '',
            baseUrl: 'assets/images/defaultEventImage1.png',
          ),
        ],
        venue: const RenderEventVenue(
          city: "Miami",
          state: "Fl",
        ),
      ),
      RenderEvent(
        title: "Black Tech Haus",
        dateTime: DateTime.utc(2022, DateTime.september, 8).toIso8601String(),
        images: const [
          RenderEventImage(
            id: '',
            baseUrl: 'assets/images/defaultEventImage2.png',
          ),
        ],
        venue: const RenderEventVenue(
          city: "Brooklyn",
          state: "Ny",
        ),
      ),
    ];
  }
}

@immutable
class RenderEventVenue {
  final String? id;
  final String? name;
  final String? address;
  final String? city;
  final String? state;
  final String? postalCode;
  final String? country;
  final double? lat;
  final double? lng;

  const RenderEventVenue({
    this.id,
    this.name,
    this.address,
    this.city,
    this.state,
    this.postalCode,
    this.country,
    this.lat,
    this.lng,
  });
}

@immutable
class RenderEventImage {
  final String? id;
  final String? baseUrl;

  const RenderEventImage({
    this.id,
    this.baseUrl,
  });
}

@immutable
class RenderEvent {
  final String? id;
  final String? title;
  final String? eventUrl;
  final String? description;
  final String? shortDescription;
  final String? dateTime;
  final String? status;
  final String? duration;
  final RenderEventVenue? venue;
  final List<RenderEventImage>? images;

  const RenderEvent({
    this.id,
    this.title,
    this.eventUrl,
    this.description,
    this.shortDescription,
    this.dateTime,
    this.venue,
    this.status,
    this.duration,
    this.images,
  });
}

@immutable
class RenderEvents {
  final Map<String, RenderEvent> entities;
  final List<String> ids;

  const RenderEvents({
    this.entities = const {},
    this.ids = const [],
  });

  Iterable<RenderEvent?> listEvents() {
    return ids.map((id) => entities[id]);
  }

  RenderEvent? getEvent(String id) {
    return entities[id];
  }
}

class RenderEventNotifier extends StateNotifier<RenderEvents> {
  RenderEventNotifier(RenderEvents state) : super(state);
}

final eventsProvider =
    StateNotifierProvider<RenderEventNotifier, RenderEvents>((ref) {
  return RenderEventNotifier(const RenderEvents());
});
