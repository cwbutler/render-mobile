// ignore_for_file: non_constant_identifier_names

import 'package:flutter/foundation.dart';

@immutable
class RenderConnection {
  final String? id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? phone;
  final String? linkedin_profile;
  final String? website;
  final String? profile_photo_url;

  const RenderConnection({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.linkedin_profile,
    this.website,
    this.profile_photo_url,
  });

  static RenderConnection fromMap(Map<String, dynamic> data) {
    return RenderConnection(
      id: data["id"],
      first_name: data["first_name"],
      last_name: data["last_name"],
      email: data["email"],
      phone: data["phone"],
      linkedin_profile: data["linkedin_profile"],
      website: data["website"],
      profile_photo_url: data["profile_photo_url"],
    );
  }
}

@immutable
class RenderConnections {
  final Map<String, RenderConnection> entities;
  final List<String> ids;
  final bool? isLoading;

  const RenderConnections({
    this.entities = const {},
    this.ids = const [],
    this.isLoading,
  });

  Iterable<RenderConnection?> listConnections() {
    return ids.map((id) => entities[id]);
  }

  RenderConnection? getConnection(String id) {
    return entities[id];
  }

  RenderConnections copyWith(RenderConnections state) {
    return RenderConnections(
      isLoading: state.isLoading ?? isLoading,
      ids: [...ids, ...state.ids],
      entities: {...entities, ...state.entities},
    );
  }

  RenderConnections removeConnection(RenderConnection connection) {
    entities.remove(connection);

    return RenderConnections(
      isLoading: isLoading,
      ids: List<String>.from(entities.keys),
      entities: entities,
    );
  }

  static RenderConnections from(List<RenderConnection> data) {
    return RenderConnections(
      isLoading: false,
      ids: List<String>.from(data.map((e) => e.id ?? "")),
      entities: Map<String, RenderConnection>.fromIterable(
        data,
        key: (e) => e.id,
      ),
    );
  }
}
