/*
* Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
*
* Licensed under the Apache License, Version 2.0 (the "License").
* You may not use this file except in compliance with the License.
* A copy of the License is located at
*
*  http://aws.amazon.com/apache2.0
*
* or in the "license" file accompanying this file. This file is distributed
* on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
* express or implied. See the License for the specific language governing
* permissions and limitations under the License.
*/

// NOTE: This file is generated and may not follow lint rules defined in your app
// Generated files can be excluded from analysis in analysis_options.yaml
// For more info, see: https://dart.dev/guides/language/analysis-options#excluding-code-from-analysis

// ignore_for_file: public_member_api_docs, annotate_overrides, dead_code, dead_codepublic_member_api_docs, depend_on_referenced_packages, file_names, library_private_types_in_public_api, no_leading_underscores_for_library_prefixes, no_leading_underscores_for_local_identifiers, non_constant_identifier_names, null_check_on_nullable_type_parameter, prefer_adjacent_string_concatenation, prefer_const_constructors, prefer_if_null_operators, prefer_interpolation_to_compose_strings, slash_for_doc_comments, sort_child_properties_last, unnecessary_const, unnecessary_constructor_name, unnecessary_late, unnecessary_new, unnecessary_null_aware_assignments, unnecessary_nullable_for_final_variable_declarations, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:amplify_core/amplify_core.dart';
import 'package:flutter/foundation.dart';


/** This is an auto generated class representing the User type in your schema. */
@immutable
class User {
  final String? _cognito_id;
  final String? _first_name;
  final String? _last_name;
  final String? _email;
  final String? _phone;
  final String? _linkedin_profile;
  final String? _website;
  final String? _resume_url;
  final String? _profile_picture;
  final String? _createdBy;
  final String? _modifiedBy;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _modifiedAt;

  String get cognito_id {
    try {
      return _cognito_id!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get first_name {
    return _first_name;
  }
  
  String? get last_name {
    return _last_name;
  }
  
  String? get email {
    return _email;
  }
  
  String? get phone {
    return _phone;
  }
  
  String? get linkedin_profile {
    return _linkedin_profile;
  }
  
  String? get website {
    return _website;
  }
  
  String? get resume_url {
    return _resume_url;
  }
  
  String? get profile_picture {
    return _profile_picture;
  }
  
  String? get createdBy {
    return _createdBy;
  }
  
  String? get modifiedBy {
    return _modifiedBy;
  }
  
  TemporalDateTime? get createdAt {
    return _createdAt;
  }
  
  TemporalDateTime? get modifiedAt {
    return _modifiedAt;
  }
  
  const User._internal({required cognito_id, first_name, last_name, email, phone, linkedin_profile, website, resume_url, profile_picture, createdBy, modifiedBy, createdAt, modifiedAt}): _cognito_id = cognito_id, _first_name = first_name, _last_name = last_name, _email = email, _phone = phone, _linkedin_profile = linkedin_profile, _website = website, _resume_url = resume_url, _profile_picture = profile_picture, _createdBy = createdBy, _modifiedBy = modifiedBy, _createdAt = createdAt, _modifiedAt = modifiedAt;
  
  factory User({required String cognito_id, String? first_name, String? last_name, String? email, String? phone, String? linkedin_profile, String? website, String? resume_url, String? profile_picture, String? createdBy, String? modifiedBy, TemporalDateTime? createdAt, TemporalDateTime? modifiedAt}) {
    return User._internal(
      cognito_id: cognito_id,
      first_name: first_name,
      last_name: last_name,
      email: email,
      phone: phone,
      linkedin_profile: linkedin_profile,
      website: website,
      resume_url: resume_url,
      profile_picture: profile_picture,
      createdBy: createdBy,
      modifiedBy: modifiedBy,
      createdAt: createdAt,
      modifiedAt: modifiedAt);
  }
  
  bool equals(Object other) {
    return this == other;
  }
  
  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is User &&
      _cognito_id == other._cognito_id &&
      _first_name == other._first_name &&
      _last_name == other._last_name &&
      _email == other._email &&
      _phone == other._phone &&
      _linkedin_profile == other._linkedin_profile &&
      _website == other._website &&
      _resume_url == other._resume_url &&
      _profile_picture == other._profile_picture &&
      _createdBy == other._createdBy &&
      _modifiedBy == other._modifiedBy &&
      _createdAt == other._createdAt &&
      _modifiedAt == other._modifiedAt;
  }
  
  @override
  int get hashCode => toString().hashCode;
  
  @override
  String toString() {
    var buffer = new StringBuffer();
    
    buffer.write("User {");
    buffer.write("cognito_id=" + "$_cognito_id" + ", ");
    buffer.write("first_name=" + "$_first_name" + ", ");
    buffer.write("last_name=" + "$_last_name" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("linkedin_profile=" + "$_linkedin_profile" + ", ");
    buffer.write("website=" + "$_website" + ", ");
    buffer.write("resume_url=" + "$_resume_url" + ", ");
    buffer.write("profile_picture=" + "$_profile_picture" + ", ");
    buffer.write("createdBy=" + "$_createdBy" + ", ");
    buffer.write("modifiedBy=" + "$_modifiedBy" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("modifiedAt=" + (_modifiedAt != null ? _modifiedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? cognito_id, String? first_name, String? last_name, String? email, String? phone, String? linkedin_profile, String? website, String? resume_url, String? profile_picture, String? createdBy, String? modifiedBy, TemporalDateTime? createdAt, TemporalDateTime? modifiedAt}) {
    return User._internal(
      cognito_id: cognito_id ?? this.cognito_id,
      first_name: first_name ?? this.first_name,
      last_name: last_name ?? this.last_name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      linkedin_profile: linkedin_profile ?? this.linkedin_profile,
      website: website ?? this.website,
      resume_url: resume_url ?? this.resume_url,
      profile_picture: profile_picture ?? this.profile_picture,
      createdBy: createdBy ?? this.createdBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : _cognito_id = json['cognito_id'],
      _first_name = json['first_name'],
      _last_name = json['last_name'],
      _email = json['email'],
      _phone = json['phone'],
      _linkedin_profile = json['linkedin_profile'],
      _website = json['website'],
      _resume_url = json['resume_url'],
      _profile_picture = json['profile_picture'],
      _createdBy = json['createdBy'],
      _modifiedBy = json['modifiedBy'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _modifiedAt = json['modifiedAt'] != null ? TemporalDateTime.fromString(json['modifiedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'cognito_id': _cognito_id, 'first_name': _first_name, 'last_name': _last_name, 'email': _email, 'phone': _phone, 'linkedin_profile': _linkedin_profile, 'website': _website, 'resume_url': _resume_url, 'profile_picture': _profile_picture, 'createdBy': _createdBy, 'modifiedBy': _modifiedBy, 'createdAt': _createdAt?.format(), 'modifiedAt': _modifiedAt?.format()
  };

  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'cognito_id',
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'first_name',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'last_name',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'email',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'phone',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'linkedin_profile',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'website',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'resume_url',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'profile_picture',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'createdBy',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'modifiedBy',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'createdAt',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.customTypeField(
      fieldName: 'modifiedAt',
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}