import 'package:flutter/material.dart';
import 'package:lime/route/routes.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/test.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(false);
        // 视频播放完毕后跳转到主页面
        _controller.addListener(() {
          if (_controller.value.position == _controller.value.duration) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Text('data')),
            );
          }
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
      body: Center(
        child: _controller.value.isInitialized
            ? VideoPlayer(_controller)
            : CircularProgressIndicator(),
      ),
    ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return       MaterialApp(
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