import 'package:api_authentication/homepage.dart';
import 'package:flutter/material.dart';
import 'signup.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const SignUpScreen(),
      routes: {
        // '/': (context) => SignUpScreen(),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}
