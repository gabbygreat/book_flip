import 'dart:math';

extension DegreeToRadian on num {
  /// Converts degrees to radians.
  double get toRadians => this * (pi / 180.0);
}
