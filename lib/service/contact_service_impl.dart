
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:phone_book/di/injector.dart';
import 'package:phone_book/model/contact_resource.dart';

import 'contact_service.dart';

class ContactServiceImpl extends ContactService {
  final Dio _http = injector<Dio>();

  Future<List<ContactResource>> getList(String name) async {
    if(name.trim() == "" || name.trim().length < 3) {
      return List.empty();
    }
    final response = await _http.get("http://localhost:8008/api/find/name/${name.trim()}");
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => ContactResource.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }
}
