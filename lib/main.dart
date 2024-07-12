import 'package:flutter/material.dart';
import 'package:flutter_getx_simple_form/views/user_form_v1.dart';
import 'package:flutter_getx_simple_form/views/user_form_v2.dart';
import 'package:flutter_getx_simple_form/views/user_form_v3.dart';
import 'package:get/get.dart';
import 'views/user_form_without_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'App GetX',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: UserFormV2(),
    );
  }
}
