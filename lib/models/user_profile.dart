// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';

@immutable
class UserProfile {
  final String? id;
  final String? first_name;
  final String? last_name;
  final String? email;
  final String? phone;
  final String? linkedin_profile;
  final String? website;
  final String? location;
  final String? profile_photo_url;
  final String? resume_url;
  final String? resume_name;

  const UserProfile({
    this.id,
    this.first_name,
    this.last_name,
    this.email,
    this.phone,
    this.linkedin_profile,
    this.location,
    this.website,
    this.profile_photo_url,
    this.resume_url,
    this.resume_name,
  });

  UserProfile copyWith(UserProfile profile) {
    return UserProfile(
      id: profile.id ?? id,
      first_name: profile.first_name ?? first_name,
      last_name: profile.last_name ?? last_name,
      email: profile.email ?? email,
      phone: profile.phone ?? phone,
      linkedin_profile: profile.linkedin_profile ?? linkedin_profile,
      website: profile.website ?? website,
      location: profile.location ?? location,
      profile_photo_url: profile.profile_photo_url ?? profile_photo_url,
      resume_url: profile.resume_url ?? resume_url,
      resume_name: profile.resume_name ?? resume_name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "first_name": first_name,
      "last_name": last_name,
      "email": email,
      "phone": phone,
      "linkedin_profile": linkedin_profile,
      "website": website,
      "location": location,
      "profile_photo_url": profile_photo_url,
      "resume_url": resume_url,
      "resume_name": resume_name,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfile && other.id == id && other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}
