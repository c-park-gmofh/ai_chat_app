import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/user/ui/user_view.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Chat App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserView(),
    );
  }
}
