import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lime/pages/be.dart';
import 'package:lime/route/routes.dart';

void main() => runApp(const Main());

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        // 初始化路由名称
        initialRoute: '/',
        onGenerateRoute: onGenerateRoute,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.greenAccent,
          highlightColor: const Color.fromRGBO(0, 0, 0, 0),
          splashColor: const Color.fromRGBO(0, 0, 0, 0),
        ),
      ),
    );
  }
}
