import 'package:json_annotation/json_annotation.dart';

part 'contact_entity_resource.g.dart';

@JsonSerializable()
class ContactEntityResource {
 int id;

 String name;

 String surname;

 String email;

 String phoneNumber;

 String mobileNumber;

 ContactEntityResource(this.id, this.name, this.surname, this.email,
      this.phoneNumber, this.mobileNumber);

 factory ContactEntityResource.fromJson(Map<String, dynamic> json) =>
     _$ContactEntityResourceFromJson(json);

 Map<String, dynamic> toJson() => _$ContactEntityResourceToJson(this);
}

