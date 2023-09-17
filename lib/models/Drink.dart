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
/* 
double caffeineRemaining(double initialAmount, Duration timePassed) {
  const double halfLifeHours = 4; // You can adjust this value
  num decayFactor = pow(1 / 2, timePassed.inMinutes / (halfLifeHours * 60));
  return initialAmount * decayFactor;
}

List<double> calculateCaffeineOverTime(
    List<Drink> drinks, DateTime currentTime) {
  List<double> caffeineContentPerMinute = List.filled(720, 0.0); // 12 hours

  for (int minute = 1; minute <= 720; minute++) {
    for (var drink in drinks) {
      Duration timePassed = currentTime
          .add(Duration(minutes: minute))
          .difference(drink.timeConsumed);
      if (timePassed.inMinutes <= 720 && timePassed.inMinutes >= 0) {
        caffeineContentPerMinute[minute - 1] +=
            caffeineRemaining(drink.caffeineContent.toDouble(), timePassed);
      }
    }
  }

  return caffeineContentPerMinute;
}
 */