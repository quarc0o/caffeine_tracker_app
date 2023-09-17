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
}
