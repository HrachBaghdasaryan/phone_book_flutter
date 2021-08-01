
import 'package:phone_book/model/contact_resource.dart';

abstract class ContactService  {

  String getName() {
    return 'contactService';
  }

  Future<List<ContactResource>> getList(String name);
}
