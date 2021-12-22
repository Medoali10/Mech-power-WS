import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zeem2/Screens/homescreen.dart';

void main() => runApp(MyApp());



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(392, 834),
        builder: () => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'DashBoardUI',
          theme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: Colors.black,
              fontFamily: 'Sans'),
          home: HomeScreen(),
        ));
  }
}
