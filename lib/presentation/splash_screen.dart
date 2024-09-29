import 'dart:async';

import 'package:easemydeal/core/routes/routes.dart';
import 'package:easemydeal/core/utils_lib/extensions.dart';
import 'package:flutter/material.dart';


/// Splash screen
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
      const Duration(milliseconds: 1000),
      () async {
        context.clearAndPush(routePath: MyRoutes.HOME);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        alignment: Alignment.center,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/spash.jpg',
              fit: BoxFit.fill,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height / 2.2,
              child: CircleAvatar(
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/appstore.png',
                    fit: BoxFit.fill,
                    width: 150,
                    height: 150,
                  ),
                ),
                radius: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
