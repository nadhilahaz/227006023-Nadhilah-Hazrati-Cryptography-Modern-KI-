import 'package:flutter/material.dart';
import 'package:nadhilahhazrati227006023/home.dart';
// import 'home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: '227006023 Nadhilah Hazrati Cryptography Modern',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
