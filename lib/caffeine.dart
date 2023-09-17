import 'models/Drink.dart';

List<double> calculateTotalCaffeineOverTime(List<Drink> drinks) {
  List<double> totalCaffeineContentPerMinute =
      List.filled(720, 0.0); // 12 hours x 60 minutes
  DateTime currentTime = DateTime.now();

  for (int minute = 1; minute <= 720; minute++) {
    for (var drink in drinks) {
      Duration timePassed = currentTime
          .add(Duration(minutes: minute))
          .difference(drink.timeConsumed);

      // Ensure that the drink was consumed in the last 12 hours.
      if (timePassed.inMinutes <= 720 && timePassed.inMinutes >= 0) {
        totalCaffeineContentPerMinute[minute - 1] +=
            caffeineRemaining(drink.caffeineContent.toDouble(), timePassed);
      }
    }
  }

  return totalCaffeineContentPerMinute;
}
