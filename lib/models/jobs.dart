import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@immutable
class RenderJob {
  final String? id;
  final String? title;
  final String? org;
  final String? summary;
  final String? url;
  final String? poc;
  final String? pocName;
  final String? category;
  final String? createdAt;

  const RenderJob({
    this.id,
    this.title,
    this.org,
    this.summary,
    this.url,
    this.poc,
    this.pocName,
    this.category,
    this.createdAt,
  });

  static RenderJob fromMap(Map<String, dynamic> data) {
    return RenderJob(
      id: data["id"],
      title: data["fields"]["Title"],
      org: data["fields"]["Org"],
      summary: data["fields"]["Summary"],
      url: data["fields"]["url"],
      poc: data["fields"]["poc"],
      pocName: data["fields"]["poc name"],
      category: data["fields"]["Category"],
      createdAt: data["fields"]["Created At"],
    );
  }
}

@immutable
class RenderJobs {
  final Map<String, RenderJob> entities;
  final List<String> ids;

  const RenderJobs({
    this.entities = const {},
    this.ids = const [],
  });

  Iterable<RenderJob?> listJobs() {
    return ids.map((id) => entities[id]);
  }

  RenderJob? getJob(String id) {
    return entities[id];
  }

  RenderJobs copyWith(RenderJobs state) {
    return RenderJobs(
      ids: [...ids, ...state.ids],
      entities: {...entities, ...state.entities},
    );
  }
}

class RenderJobNotifier extends StateNotifier<RenderJobs> {
  RenderJobNotifier(RenderJobs state) : super(state);

  Future<RenderJobs> fetchJobs() async {
    try {
      final result =
          await FirebaseFunctions.instance.httpsCallable('fetchJobs').call();
      final data = json.decode(json.encode(result.data));
      final List<RenderJob> list = List.from(
        List.from(data).map((item) => RenderJob.fromMap(item)),
      );
      state = state.copyWith(RenderJobs(
        ids: List<String>.from(list.map((e) => e.id ?? "")),
        entities: Map<String, RenderJob>.fromIterable(list, key: (e) => e.id),
      ));
      return state;
    } catch (e) {
      debugPrint("Error fetching jobs list: $e");
    }
    return state;
  }
}

final jobsProvider =
    StateNotifierProvider<RenderJobNotifier, RenderJobs>((ref) {
  return RenderJobNotifier(const RenderJobs());
});
