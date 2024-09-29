import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';

extension ContextExtension on BuildContext {
  void to({required Widget screen}) 
  {
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
  }

  ///Pops all screen until last screen then replaces it with the required screen
  void clearAndPush({required String routePath, Object? args}) {
    while (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    }
    GoRouter.of(this).pushReplacement(routePath, extra: args);
  }

  }



