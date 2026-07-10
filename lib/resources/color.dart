import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
Color forestGreen =const Color.fromARGB(255, 34, 139, 34);

class GradientDecoration {
  static BoxDecoration getBackground() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: const Alignment(0.7, 1),
        colors: <Color>[
          Colors.deepPurple.withOpacity(0.7),
          Colors.black.withOpacity(0.8),
        ],
        tileMode: TileMode.mirror,
      ),
    );
  }
}
