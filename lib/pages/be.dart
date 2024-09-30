import 'package:flutter/material.dart';
import 'package:lime/route/routes.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatelessWidget {
  final ValueNotifier<bool> end;
  final VideoPlayerController controller;

  const SplashScreen({super.key, required this.end, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: end,
        builder: (context, value, child) {
          return MaterialApp(
            // 初始化路由名称
            initialRoute: '/',
            onGenerateRoute: onGenerateRoute,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.greenAccent,
              highlightColor: const Color.fromRGBO(0, 0, 0, 0),
              splashColor: const Color.fromRGBO(0, 0, 0, 0),
            ),
          );
        });
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 初始化路由名称
      initialRoute: '/',
      onGenerateRoute: onGenerateRoute,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
        highlightColor: const Color.fromRGBO(0, 0, 0, 0),
        splashColor: const Color.fromRGBO(0, 0, 0, 0),
      ),
    );
  }
}
