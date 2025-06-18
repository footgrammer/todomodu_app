import 'package:flutter/material.dart';

/// Returns a bright pastel color based on [seed].
Color brightPastelFromSeed(String seed) {
  final hash = seed.hashCode.abs();
  final hue = (hash % 360).toDouble();

  // Increase lightness to 0.85 or 0.9 for a really bright feel.
  // You can also lower saturation a bit (e.g. 0.4) to keep it pastel.
  final hsl = HSLColor.fromAHSL(
    1.0,    // alpha
    hue,    // hue
    0.4,    // saturation (0.0–1.0)
    0.85,   // lightness (0.0–1.0), higher → brighter
  );
  return hsl.toColor();
}

