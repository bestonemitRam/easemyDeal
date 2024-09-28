import 'package:easemydeal/core/constant/custom_theme.dart';
import 'package:easemydeal/core/routes/routes.dart';
import 'package:easemydeal/logic/story_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';

class MyApplication extends StatefulWidget {
  const MyApplication({super.key});

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GlobalLoaderOverlay(
        overlayColor: AppColor.black,
        child: StreamProvider<InternetConnectionStatus>(
          initialData: InternetConnectionStatus.connected,
          create: (_) {
            return InternetConnectionChecker().onStatusChange;
          },
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (ctx) => StoryProvider(),
              ),
            ],
            child: MaterialApp.router(
              routerConfig: MyRoutes.router,
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              title: "EaseMyDeal",
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
