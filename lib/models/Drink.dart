import 'dart:math';

class Drink {
  final String drinkName;
  final int caffeineContent;
  final int timestamp;

  Drink({
    required this.drinkName,
    required this.caffeineContent,
    required this.timestamp,
  });

  factory Drink.fromMap(Map<dynamic, dynamic> map) {
    return Drink(
      drinkName: map['drink_name'],
      caffeineContent: map['caffeine_content'],
      timestamp: int.parse(map['timestamp']),
    );
  }

  DateTime get timeConsumed => DateTime.fromMillisecondsSinceEpoch(timestamp);
}

double caffeineRemaining(double initialAmount, Duration timePassed) {
  const double halfLifeHours = 4; // You can adjust this value
  num decayFactor = pow(1 / 2, timePassed.inHours / halfLifeHours);
  return initialAmount * decayFactor;
}

List<double> calculateCaffeineOverTime(
    List<Drink> drinks, DateTime currentTime) {
  List<double> caffeineContentPerHour = List.filled(12, 0.0); // 12 hours

  for (int hour = 1; hour <= 12; hour++) {
    for (var drink in drinks) {
      Duration timePassed =
          currentTime.add(Duration(hours: hour)).difference(drink.timeConsumed);
      if (timePassed.inHours < 12) {
        caffeineContentPerHour[hour - 1] +=
            caffeineRemaining(drink.caffeineContent.toDouble(), timePassed);
      }
    }
  }

  return caffeineContentPerHour;
}
