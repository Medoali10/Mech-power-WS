import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:avatar_glow/avatar_glow.dart';




class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final databaseRef = FirebaseDatabase.instance.reference();
  double volt = 0;
  double current = 0.18;
  double power = 0;

  @override
  void initState() {
    super.initState();
    databaseRef.onValue.listen((event) {
        setState(() {
          volt = double.parse((event.snapshot.value["float"]).toStringAsPrecision(5));
          if(volt == 0){
            current = 0;
          }else {
            current = 0.18;
          }
          power = double.parse((event.snapshot.value["float"]  * current).toStringAsPrecision(5));
        });
});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(children: [
            Icon(
              FeatherIcons.home,
              size: 25.0.r,
              color: Colors.white,
            )
          ]),
          actions: [
            SizedBox(width: 40.w),
            IconButton(
              onPressed: () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Container(
                height: 100,
                child: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(FeatherIcons.x),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        Text("About"),
                        SizedBox(
                          height: 25,
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            );
          });
    },
              icon: Icon(FeatherIcons.helpCircle),
              iconSize: 25.0.r,
              color: Colors.white,
            ),
            SizedBox(
              width: 10.w,
            )
          ],
        ),
        body: SafeArea(
            child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10.w, 10.h, 10.w, 10.h),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(5.0.r)),
                          child: Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Colors.grey.shade800,
                                      const Color(0xFF000000),
                                    ])),
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                                padding: EdgeInsets.all(15.0.r),
                                child: Column(
                                  children: [
                                    Text(
                                      'Mech-power WS',
                                      style:
                                      TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                    AvatarGlow(
                                      glowColor: Colors.yellow,
                                      endRadius: 150.0,
                                      duration: Duration(milliseconds: 2000),
                                      repeat: true,
                                      showTwoGlows: true,
                                      repeatPauseDuration: Duration(milliseconds: 100),
                                      shape: BoxShape.circle,
                                      child: Material(
                                        elevation: 2,
                                        shape: CircleBorder(
                                        ),
                                        color: Colors.yellow,
                                        child: SizedBox(
                                          height: 200,
                                          width: 200,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Energy generated per hour',
                                                style: TextStyle(
                                                    fontSize: 15.sp, fontWeight: FontWeight.w700, color: Colors.black),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "$power Wh",
                                                style: TextStyle(
                                                    fontSize: 21.sp, fontWeight: FontWeight.w700, color: Colors.black),
                                              ),

                                            ],
                                          ),
                                        ),
                                      ),),
                                    SizedBox(
                                      height: 15.sp,
                                    ),
                                    SizedBox(
                                      height: 25.sp,
                                    ),
                                    SizedBox(
                                      height: 15.h,
                                    ),
                                  ],
                                )),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VALUES',
                        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 15.h),
                      Column(
                        children: [
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(3.0.r)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: const Color(0xFF222222),
                                  ),
                                  // color: const Color(0xFF222222),
                                  width: 180.w,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 20.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Icon(
                                          FeatherIcons.power,
                                          size: 35.0.r,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Text(
                                          '$current A',
                                          style: TextStyle(fontSize: 22.sp),
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Current',
                                              style: TextStyle(fontSize: 15.sp),
                                            ),
                                            Icon(
                                              FeatherIcons.arrowRight,
                                              size: 25.0.r,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(3.0.r)),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    color: const Color(0xFF222222),
                                  ),
                                  // color: const Color(0xFF222222),
                                  width: 180.w,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(15.w, 20.h, 15.w, 20.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        Icon(
                                          FeatherIcons.power,
                                          size: 35.0.r,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          height: 15.h,
                                        ),
                                        Text(
                                          '$volt V',
                                          style: TextStyle(fontSize: 22.sp),
                                        ),
                                        SizedBox(height: 10.sp),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Volt',
                                              style: TextStyle(fontSize: 15.sp),
                                            ),
                                            Icon(
                                              FeatherIcons.arrowRight,
                                              size: 25.0.r,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ],
                      )
                    ],
                  ),
                        SizedBox(height: 200.h),
                      ],
                    )))));
  }

}
