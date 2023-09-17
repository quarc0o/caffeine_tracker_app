import 'models/Drink.dart';

List<double> calculateTotalCaffeineOverTime(List<Drink> drinks) {
  List<double> totalCaffeineContentPerHour = List.filled(12, 0.0); // 12 hours
  DateTime currentTime = DateTime.now();

  for (int hour = 1; hour <= 12; hour++) {
    for (var drink in drinks) {
      Duration timePassed =
          currentTime.add(Duration(hours: hour)).difference(drink.timeConsumed);

      // Ensure that the drink was consumed in the last 12 hours.
      if (timePassed.inHours <= 12 && timePassed.inHours >= 0) {
        totalCaffeineContentPerHour[hour - 1] +=
            caffeineRemaining(drink.caffeineContent.toDouble(), timePassed);
      }
    }
  }

  return totalCaffeineContentPerHour;
}
