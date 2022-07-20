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
class User extends Model {
  static const classType = const _UserModelType();
  final String id;
  final String? _email;
  final String? _last_name;
  final String? _first_name;
  final String? _phone;
  final String? _linkedin_profile;
  final String? _website;
  final String? _resume;
  final String? _profile_picture;
  final String? _createdBy;
  final String? _modifiedBy;
  final TemporalDateTime? _createdAt;
  final TemporalDateTime? _modifiedAt;
  final TemporalDateTime? _updatedAt;

  @override
  getInstanceType() => classType;
  
  @override
  String getId() {
    return id;
  }
  
  String get email {
    try {
      return _email!;
    } catch(e) {
      throw new AmplifyCodeGenModelException(
          AmplifyExceptionMessages.codeGenRequiredFieldForceCastExceptionMessage,
          recoverySuggestion:
            AmplifyExceptionMessages.codeGenRequiredFieldForceCastRecoverySuggestion,
          underlyingException: e.toString()
          );
    }
  }
  
  String? get last_name {
    return _last_name;
  }
  
  String? get first_name {
    return _first_name;
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
  
  String? get resume {
    return _resume;
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
  
  TemporalDateTime? get updatedAt {
    return _updatedAt;
  }
  
  const User._internal({required this.id, required email, last_name, first_name, phone, linkedin_profile, website, resume, profile_picture, createdBy, modifiedBy, createdAt, modifiedAt, updatedAt}): _email = email, _last_name = last_name, _first_name = first_name, _phone = phone, _linkedin_profile = linkedin_profile, _website = website, _resume = resume, _profile_picture = profile_picture, _createdBy = createdBy, _modifiedBy = modifiedBy, _createdAt = createdAt, _modifiedAt = modifiedAt, _updatedAt = updatedAt;
  
  factory User({String? id, required String email, String? last_name, String? first_name, String? phone, String? linkedin_profile, String? website, String? resume, String? profile_picture, String? createdBy, String? modifiedBy, TemporalDateTime? createdAt, TemporalDateTime? modifiedAt}) {
    return User._internal(
      id: id == null ? UUID.getUUID() : id,
      email: email,
      last_name: last_name,
      first_name: first_name,
      phone: phone,
      linkedin_profile: linkedin_profile,
      website: website,
      resume: resume,
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
      id == other.id &&
      _email == other._email &&
      _last_name == other._last_name &&
      _first_name == other._first_name &&
      _phone == other._phone &&
      _linkedin_profile == other._linkedin_profile &&
      _website == other._website &&
      _resume == other._resume &&
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
    buffer.write("id=" + "$id" + ", ");
    buffer.write("email=" + "$_email" + ", ");
    buffer.write("last_name=" + "$_last_name" + ", ");
    buffer.write("first_name=" + "$_first_name" + ", ");
    buffer.write("phone=" + "$_phone" + ", ");
    buffer.write("linkedin_profile=" + "$_linkedin_profile" + ", ");
    buffer.write("website=" + "$_website" + ", ");
    buffer.write("resume=" + "$_resume" + ", ");
    buffer.write("profile_picture=" + "$_profile_picture" + ", ");
    buffer.write("createdBy=" + "$_createdBy" + ", ");
    buffer.write("modifiedBy=" + "$_modifiedBy" + ", ");
    buffer.write("createdAt=" + (_createdAt != null ? _createdAt!.format() : "null") + ", ");
    buffer.write("modifiedAt=" + (_modifiedAt != null ? _modifiedAt!.format() : "null") + ", ");
    buffer.write("updatedAt=" + (_updatedAt != null ? _updatedAt!.format() : "null"));
    buffer.write("}");
    
    return buffer.toString();
  }
  
  User copyWith({String? id, String? email, String? last_name, String? first_name, String? phone, String? linkedin_profile, String? website, String? resume, String? profile_picture, String? createdBy, String? modifiedBy, TemporalDateTime? createdAt, TemporalDateTime? modifiedAt}) {
    return User._internal(
      id: id ?? this.id,
      email: email ?? this.email,
      last_name: last_name ?? this.last_name,
      first_name: first_name ?? this.first_name,
      phone: phone ?? this.phone,
      linkedin_profile: linkedin_profile ?? this.linkedin_profile,
      website: website ?? this.website,
      resume: resume ?? this.resume,
      profile_picture: profile_picture ?? this.profile_picture,
      createdBy: createdBy ?? this.createdBy,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      createdAt: createdAt ?? this.createdAt,
      modifiedAt: modifiedAt ?? this.modifiedAt);
  }
  
  User.fromJson(Map<String, dynamic> json)  
    : id = json['id'],
      _email = json['email'],
      _last_name = json['last_name'],
      _first_name = json['first_name'],
      _phone = json['phone'],
      _linkedin_profile = json['linkedin_profile'],
      _website = json['website'],
      _resume = json['resume'],
      _profile_picture = json['profile_picture'],
      _createdBy = json['createdBy'],
      _modifiedBy = json['modifiedBy'],
      _createdAt = json['createdAt'] != null ? TemporalDateTime.fromString(json['createdAt']) : null,
      _modifiedAt = json['modifiedAt'] != null ? TemporalDateTime.fromString(json['modifiedAt']) : null,
      _updatedAt = json['updatedAt'] != null ? TemporalDateTime.fromString(json['updatedAt']) : null;
  
  Map<String, dynamic> toJson() => {
    'id': id, 'email': _email, 'last_name': _last_name, 'first_name': _first_name, 'phone': _phone, 'linkedin_profile': _linkedin_profile, 'website': _website, 'resume': _resume, 'profile_picture': _profile_picture, 'createdBy': _createdBy, 'modifiedBy': _modifiedBy, 'createdAt': _createdAt?.format(), 'modifiedAt': _modifiedAt?.format(), 'updatedAt': _updatedAt?.format()
  };

  static final QueryField ID = QueryField(fieldName: "user.id");
  static final QueryField EMAIL = QueryField(fieldName: "email");
  static final QueryField LAST_NAME = QueryField(fieldName: "last_name");
  static final QueryField FIRST_NAME = QueryField(fieldName: "first_name");
  static final QueryField PHONE = QueryField(fieldName: "phone");
  static final QueryField LINKEDIN_PROFILE = QueryField(fieldName: "linkedin_profile");
  static final QueryField WEBSITE = QueryField(fieldName: "website");
  static final QueryField RESUME = QueryField(fieldName: "resume");
  static final QueryField PROFILE_PICTURE = QueryField(fieldName: "profile_picture");
  static final QueryField CREATEDBY = QueryField(fieldName: "createdBy");
  static final QueryField MODIFIEDBY = QueryField(fieldName: "modifiedBy");
  static final QueryField CREATEDAT = QueryField(fieldName: "createdAt");
  static final QueryField MODIFIEDAT = QueryField(fieldName: "modifiedAt");
  static var schema = Model.defineSchema(define: (ModelSchemaDefinition modelSchemaDefinition) {
    modelSchemaDefinition.name = "User";
    modelSchemaDefinition.pluralName = "Users";
    
    modelSchemaDefinition.authRules = [
      AuthRule(
        authStrategy: AuthStrategy.PUBLIC,
        operations: [
          ModelOperation.CREATE,
          ModelOperation.UPDATE,
          ModelOperation.DELETE,
          ModelOperation.READ
        ])
    ];
    
    modelSchemaDefinition.addField(ModelFieldDefinition.id());
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.EMAIL,
      isRequired: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.LAST_NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.FIRST_NAME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PHONE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.LINKEDIN_PROFILE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.WEBSITE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.RESUME,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.PROFILE_PICTURE,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.CREATEDBY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.MODIFIEDBY,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.string)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.CREATEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.field(
      key: User.MODIFIEDAT,
      isRequired: false,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
    
    modelSchemaDefinition.addField(ModelFieldDefinition.nonQueryField(
      fieldName: 'updatedAt',
      isRequired: false,
      isReadOnly: true,
      ofType: ModelFieldType(ModelFieldTypeEnum.dateTime)
    ));
  });
}

class _UserModelType extends ModelType<User> {
  const _UserModelType();
  
  @override
  User fromJson(Map<String, dynamic> jsonData) {
    return User.fromJson(jsonData);
  }
}