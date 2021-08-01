
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:phone_book/di/injector.dart';
import 'package:phone_book/model/contact_entity_resource.dart';
import 'package:phone_book/model/contact_resource.dart';

import 'admin_service.dart';
import 'contact_service.dart';

class AdminServiceImpl extends AdminService {
  final Dio _http = injector<Dio>();
  Codec<String, String> stringToBase64 = utf8.fuse(base64);

  Future<List<ContactEntityResource>> getList(String name, String token) async {
    if(name.trim() == "" || name.trim().length < 3) {
      return List.empty();
    }
    Map<String, String> headers = {
      "Content-type": "application/json;charset=UTF-8",
      "authorization": "Basic ${stringToBase64.encode(token)}"
    };
    final response = await _http.get("http://localhost:8008/api/contact/name/${name.trim()}",
        options: Options(headers: headers)
    );
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => ContactEntityResource.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  @override
  Future<Response> create(ContactResource contactResource, String token) async {
    Map<String, String> headers = {
      "Content-type": "application/json;charset=UTF-8",
      "Authorization": "Basic ${stringToBase64.encode(token)}"
    };
    return _http.post("http://localhost:8008/api/contact",
      options: Options(headers: headers),
      data: jsonEncode(contactResource),
    );
  }

  @override
  Future<Response> delete(int id, String token) async {
    Map<String, String> headers = {
      "Content-type": "application/json;charset=UTF-8",
      "Authorization": "Basic ${stringToBase64.encode(token)}"
    };
    return _http.delete("http://localhost:8008/api/contact/$id",
      options: Options(headers: headers)
    );

  }
}
