import 'package:dio/dio.dart';
import 'package:phone_book/service/admin_service.dart';
import 'package:phone_book/service/admin_service_impl.dart';
import 'package:phone_book/service/contact_service.dart';
import 'package:phone_book/service/contact_service_impl.dart';

import 'injector.dart';

Future<void> configure() async {

  injector.registerSingleton<Dio>(Dio());
  injector.registerSingleton<ContactService>(ContactServiceImpl());
  injector.registerSingleton<AdminService>(AdminServiceImpl());

}
