import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';





class InternetNotAvailable extends StatefulWidget {
  static const String routeName = '/internetNotAvailable';

  InternetNotAvailable({super.key, double? height});

  @override
  State<InternetNotAvailable> createState() => _InternetNotAvailableState();
}

class _InternetNotAvailableState extends State<InternetNotAvailable> {
  double? height;
  bool isRefresh = false;

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: height ?? 55.h,
        //   width: 50.w,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/no_internet.png',
                width: 50.w,
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                "No Internet Connection",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w900),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "Check your connection, Then refresh the page.",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              SizedBox(
                height: 4.h,
              ),
              InkWell(
                onTap: () {
                  setState(() 
                  {
                    isRefresh = true;
                  });
               
                },
                child: Column(
                  children: [
                    !isRefresh
                        ? Icon(Icons.refresh)
                        : CircularProgressIndicator(
                            color: Colors.black,
                          ),
                    Text(
                      "Please refresh !",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
