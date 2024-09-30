import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/pages/be.dart';
import 'package:lime/route/routes.dart';
import 'package:video_player/video_player.dart';

Future<void> main() async {
     WidgetsFlutterBinding.ensureInitialized();
  final ValueNotifier<bool> _end = ValueNotifier<bool>(false);
  final VideoPlayerController _controller =
      VideoPlayerController.asset('assets/test.mp4');
  await _controller.initialize().then((_) {
    _controller.play();
    _controller.setLooping(false);
    // 视频播放完毕后跳转到主页面
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        _end.value = true;
      }
    });
  });
  runApp(Main(
    end: _end,
    controller: _controller,
  ));
}

class Main extends StatelessWidget {
  final ValueNotifier<bool> end;
  final VideoPlayerController controller;
  const Main({Key? key, required this.end, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: SplashScreen(
        end: end,
        controller: controller,
      ),
    );
  }
}
