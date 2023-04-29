import 'package:flutter/material.dart';

/// физика скролла для ios
class MyBehaviorIOS extends ScrollBehavior {
  const MyBehaviorIOS();
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) => const BouncingScrollPhysics();
}
/// физика скролла для Android
class MyBehaviorAndroid extends ScrollBehavior {
  @override
  Widget buildOverscrollIndicator(
      BuildContext context, Widget child, ScrollableDetails details) {
    return child;
  }
}