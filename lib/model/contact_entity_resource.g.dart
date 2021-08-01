// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_entity_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactEntityResource _$ContactEntityResourceFromJson(
    Map<String, dynamic> json) {
  return ContactEntityResource(
    json['id'] as int,
    json['name'] as String,
    json['surname'] as String,
    json['email'] as String,
    json['phoneNumber'] as String,
    json['mobileNumber'] as String,
  );
}

Map<String, dynamic> _$ContactEntityResourceToJson(
        ContactEntityResource instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'mobileNumber': instance.mobileNumber,
    };
