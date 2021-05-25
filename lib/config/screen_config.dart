import 'dart:ui';

import 'package:flutter/widgets.dart';

/// Config something of the new feed screen like: Scaffold background...
///
class ScreenConfig {
  final Color backgroundColor;

  /// All of content video will load from network, this is screen loading not video loading
  ///
  final Widget loadingWidget;

  /// when no result, can customize the empty widget
  ///
  final Widget? emptyWidget;

  const ScreenConfig({
    required this.backgroundColor,
    required this.loadingWidget,
    this.emptyWidget,
  });
}
