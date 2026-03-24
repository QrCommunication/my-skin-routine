import 'package:flutter/material.dart';

class AppMotion {
  AppMotion._();

  static const Duration durationShort = Duration(milliseconds: 200);
  static const Duration durationMedium = Duration(milliseconds: 350);
  static const Duration durationLong = Duration(milliseconds: 500);

  static const Curve expressiveCurve = Curves.easeOutBack;
  static const Curve standardCurve = Curves.easeOutCubic;

  static SpringDescription get standardSpring {
    return const SpringDescription(
      mass: 1.0,
      stiffness: 300,
      damping: 20,
    );
  }

  static SpringDescription get emphasizedSpring {
    return const SpringDescription(
      mass: 1.0,
      stiffness: 150,
      damping: 12,
    );
  }

  static SpringDescription get quickSpring {
    return const SpringDescription(
      mass: 1.0,
      stiffness: 600,
      damping: 30,
    );
  }

  static Animation<double> createStandardAnimation(
    AnimationController controller,
  ) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: standardCurve,
      ),
    );
  }

  static Animation<double> createEmphasizedAnimation(
    AnimationController controller,
  ) {
    return Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: expressiveCurve,
      ),
    );
  }
}
