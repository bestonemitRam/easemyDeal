import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';


import 'package:loader_overlay/loader_overlay.dart';

extension ContextExtension on BuildContext {
  void to({required Widget screen}) {
    Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
  }

  ///Pops all screen until last screen then replaces it with the required screen
  void clearAndPush({required String routePath, Object? args}) {
    while (GoRouter.of(this).canPop()) {
      GoRouter.of(this).pop();
    }
    GoRouter.of(this).pushReplacement(routePath, extra: args);
  }

  /// Get color scheme
  ColorScheme get appColor => Theme.of(this).colorScheme;

  /// Get current height of the screen
  double get height => MediaQuery.of(this).size.height;

  /// Get current height of the screen
  double get width => MediaQuery.of(this).size.width;

  /// Provides safe context
  BuildContext? getSafeContext() {
    if (mounted) {
      return this;
    }
    return null;
  }

  /// show global loader
  void showLoader({bool show = true}) 
  {
    if (mounted) {
      if (show) {
        loaderOverlay.show();
      } else {
        loaderOverlay.hide();
      }
    }
  }
}



