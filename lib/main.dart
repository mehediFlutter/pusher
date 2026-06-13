import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pusher_p/home_screen.dart';
import 'package:pusher_p/push_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  PusherManager().initPusher();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HomeScreen(),
    );
  }
}
