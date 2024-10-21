import 'package:flutter/material.dart';

enum WindowSizeClass {
  compact,
  medium,
  expanded,
  large,
  extraLarge;

  static WindowSizeClass of(BuildContext context) {
    final size = MediaQuery.of(context).size;

    switch (size.width) {
      case < 600:
        return compact;
      case < 840:
        return medium;
      case < 1200:
        return expanded;
      case < 1600:
        return large;
      default:
        return extraLarge;
    }
  }
}
