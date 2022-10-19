// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

@immutable
class EventsToken {
  final String refresh_token;
  final String access_token;
  final int expires_in;

  const EventsToken({
    required this.access_token,
    required this.refresh_token,
    required this.expires_in,
  });
}

class EventsApi {
  static EventsToken? token;
  static bool? isLoaded = false;
  static String host = "https://api.meetup.com/gql";

  EventsApi();

  static Future<void> init() async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('getMeetupAccess')
          .call();
      if (result.data["access_token"] != null) {
        token = EventsToken(
          access_token: result.data["access_token"],
          refresh_token: result.data["refresh_token"],
          expires_in: result.data['expires_in'],
        );
      }
      isLoaded = true;
    } catch (e) {
      debugPrint("Error on events init ${e.toString()}");
    }
  }

  static Future<Map<String, dynamic>> queryMeetup(String query) async {
    final url = Uri.parse(host);
    final response = await http.post(
      url,
      body: jsonEncode({"query": query}),
      headers: {
        'Authorization': 'Bearer ${token?.access_token}',
        'Content-Type': 'application/json',
      },
    );
    return json.decode(response.body);
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

  static RenderEventVenue fromMap(Map<String, dynamic> data) {
    return RenderEventVenue(
      id: data["id"],
      name: data["name"],
      address: data["address"],
      city: data["city"],
      state: data["state"],
      postalCode: data["postalCode"],
      country: data["country"],
      lat: data["lat"],
      lng: data["lng"],
    );
  }
}

@immutable
class RenderEventImage {
  final String? id;
  final String? baseUrl;

  const RenderEventImage({
    this.id,
    this.baseUrl,
  });

  static RenderEventImage fromMap(Map<String, dynamic> data) {
    return RenderEventImage(
      id: data["id"],
      baseUrl: data["baseUrl"],
    );
  }
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

  static RenderEvent fromMap(Map<String, dynamic> data) {
    return RenderEvent(
      id: data["id"],
      title: data["title"],
      eventUrl: data["eventUrl"],
      description: data["description"],
      shortDescription: data["shortDescription"],
      dateTime: data["dateTime"],
      status: data["status"],
      duration: data["duration"],
      venue: RenderEventVenue.fromMap(data["venue"]),
      images: List.from(
        List.from(data["images"]).map((e) => RenderEventImage.fromMap(e)),
      ),
    );
  }
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

  RenderEvents copyWith(RenderEvents state) {
    return RenderEvents(
      ids: [...ids, ...state.ids],
      entities: {...entities, ...state.entities},
    );
  }
}

class RenderEventNotifier extends StateNotifier<RenderEvents> {
  RenderEventNotifier(RenderEvents state) : super(state);

  Future<RenderEvents> fetchEvents() async {
    try {
      final result = await FirebaseFunctions.instance
          .httpsCallable('fetchMeetupEvents')
          .call();
      final data = json.decode(json.encode(result.data));
      final List<RenderEvent> list = List.from(
        List.from(data).map((item) => RenderEvent.fromMap(item["node"])),
      );
      state = state.copyWith(RenderEvents(
        ids: List<String>.from(list.map((e) => e.id ?? "")),
        entities: Map<String, RenderEvent>.fromIterable(list, key: (e) => e.id),
      ));
      return state;
    } catch (e) {
      debugPrint("Error fetching event list: $e");
    }
    return state;
  }
}

final eventsProvider =
    StateNotifierProvider<RenderEventNotifier, RenderEvents>((ref) {
  return RenderEventNotifier(const RenderEvents());
});
