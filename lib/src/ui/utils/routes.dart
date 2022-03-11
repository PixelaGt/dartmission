import 'package:animations/animations.dart';
import 'package:flutter/widgets.dart';

Route<dynamic> customPageRoute(Widget childWidget) {
  return PageRouteBuilder<dynamic>(
    pageBuilder: (
      context,
      animation,
      secondaryAnimation,
    ) =>
        childWidget,
    transitionsBuilder: (
      context,
      animation,
      secondaryAnimation,
      child,
    ) =>
        SharedAxisTransition(
      animation: animation,
      secondaryAnimation: secondaryAnimation,
      transitionType: SharedAxisTransitionType.scaled,
      child: child,
    ),
  );
}
