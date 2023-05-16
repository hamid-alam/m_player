import 'package:flutter/material.dart';
import 'package:m_player/const/colors.dart';
import 'package:m_player/views/home.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'M Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
          primarySwatch: Colors.purple,
          canvasColor: bgDarkColor,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
          )),
      home: const Home(),
    );
  }
}
