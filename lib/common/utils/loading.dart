import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventi/common/widgets/loading_indicator.dart';

class OverlayUtils {
  /// Show a global overlay with a loading indicator
  static Future<T> runWithOverlay<T>({
    required Future<T> Function() asyncFunction,
    Widget? loadingWidget,
  }) {
    return Get.showOverlay(
      asyncFunction: asyncFunction,
      loadingWidget: loadingWidget ??
          const Center(
            child: LoadingIndicator(),
          ),
    );
  }
}
