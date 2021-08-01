// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactResource _$ContactResourceFromJson(Map<String, dynamic> json) {
  return ContactResource(
    json['name'] as String,
    json['surname'] as String,
    json['email'] as String,
    json['phoneNumber'] as String,
    json['mobileNumber'] as String,
  );
}

Map<String, dynamic> _$ContactResourceToJson(ContactResource instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'email': instance.email,
      'phoneNumber': instance.phoneNumber,
      'mobileNumber': instance.mobileNumber,
    };
