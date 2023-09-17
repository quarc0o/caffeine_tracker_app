import 'Drink.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  List<Drink>? drinks;

  UserModel(
      {required this.id, required this.name, required this.email, this.drinks});
}
