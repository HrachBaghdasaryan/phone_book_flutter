import 'package:dio/dio.dart';
import 'package:phone_book/model/contact_entity_resource.dart';
import 'package:phone_book/model/contact_resource.dart';

abstract class AdminService {
  String getName() {
    return 'adminService';
  }

  Future<List<ContactEntityResource>> getList(String name, String token);

  Future<Response> delete(int id, String token);

  Future<Response> create(ContactResource contactResource, String token);
}
