import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Transition {
  static CustomTransitionPage pageTransition(
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: Duration(milliseconds: 350),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var fadeAnimation = CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        );

        var slideAnimation = Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(animation);

        var reverseSlideAnimation = Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1.0, 0.0),
        ).animate(secondaryAnimation);

        return FadeTransition(
          opacity: fadeAnimation,
          child: SlideTransition(
            position:
                animation.status == AnimationStatus.reverse
                    ? reverseSlideAnimation
                    : slideAnimation,
            child: child,
          ),
        );
      },
    );
  }
}
