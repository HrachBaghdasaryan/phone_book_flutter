import 'package:json_annotation/json_annotation.dart';

part 'contact_resource.g.dart';

@JsonSerializable()
class ContactResource {
 String name;

 String surname;

 String email;

 String phoneNumber;

 String mobileNumber;

 ContactResource(
      this.name, this.surname, this.email, this.phoneNumber, this.mobileNumber);

 factory ContactResource.fromJson(Map<String, dynamic> json) =>
     _$ContactResourceFromJson(json);

 Map<String, dynamic> toJson() => _$ContactResourceToJson(this);
}
