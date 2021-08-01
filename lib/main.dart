import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:phone_book/ui/admin_screen.dart';
import 'package:phone_book/ui/search.dart';

import 'di/registry.dart';

void main() async {
  bool isRunFirstTime = true;
  if (isRunFirstTime) {
    configure();
  }
  isRunFirstTime = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Phone Book',
      home: SearchScreen(),
      routes: {"/admin": (context) => AdminPanel()},
    );
  }
}
