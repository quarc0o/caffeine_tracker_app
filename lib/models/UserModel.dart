import 'Drink.dart';
import 'dart:math';

class UserModel {
  final String id;
  final String name;
  final String email;
  int? weight;
  int? age;
  CaffeineTolerance? tolerance;
  List<Drink>? drinks;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      this.weight,
      this.age,
      this.tolerance,
      this.drinks});
}

enum CaffeineTolerance { LOW, MEDIUM, HIGH }

extension CaffeineToleranceExtension on CaffeineTolerance {
  String get description {
    switch (this) {
      case CaffeineTolerance.LOW:
        return "Low";
      case CaffeineTolerance.MEDIUM:
        return "Medium";
      case CaffeineTolerance.HIGH:
        return "High";
      default:
        return this
            .toString()
            .split('.')
            .last; // This will return string like "LOW", "MEDIUM", etc.
    }
  }
}

double adjustHalfLifeForUser(double baseHalfLife, UserModel user) {
  double adjustedHalfLife = baseHalfLife;

  if (user.age != null && user.age! > 20) {
    adjustedHalfLife += 0.05 * (user.age! - 20);
  }

  if (user.weight != null && user.weight! > 60) {
    adjustedHalfLife -= 0.02 * ((user.weight! - 60) / 10);
  }

  if (user.tolerance != null) {
    switch (user.tolerance) {
      case CaffeineTolerance.LOW:
        adjustedHalfLife *= 1.1; // 10% increase for low tolerance
        break;
      case CaffeineTolerance.HIGH:
        adjustedHalfLife *= 0.9; // 10% decrease for high tolerance
        break;
      default:
        break; // No adjustment for medium tolerance
    }
  }

  return adjustedHalfLife;
}

double caffeineRemaining(
    double initialAmount, Duration timePassed, UserModel user) {
  const double baseHalfLifeHours = 4;
  double halfLifeHours = adjustHalfLifeForUser(baseHalfLifeHours, user);
  num decayFactor = pow(1 / 2, timePassed.inMinutes / (halfLifeHours * 60));
  return initialAmount * decayFactor;
}

List<double> calculateCaffeineOverTime(List<Drink> drinks, UserModel user) {
  List<double> totalCaffeineContentPerMinute = List.filled(720, 0.0);
  DateTime currentTime = DateTime.now();

  for (int minute = 1; minute <= 720; minute++) {
    for (var drink in drinks) {
      Duration timePassed = currentTime
          .add(Duration(minutes: minute))
          .difference(drink.timeConsumed);

      if (timePassed.inMinutes <= 720 && timePassed.inMinutes >= 0) {
        totalCaffeineContentPerMinute[minute - 1] += caffeineRemaining(
            drink.caffeineContent.toDouble(), timePassed, user);
      }
    }
  }

  return totalCaffeineContentPerMinute;
}
