import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/UserProvider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String? name = "John Doe"; // Replace this with actual data
  int? age = 20;
  int? weight = 70;
  String? caffeineTolerance = "Moderat";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Profile"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, $name!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text("Alder: $age"),
            SizedBox(height: 10),
            Text("Weight: ${weight}kg"),
            SizedBox(height: 10),
            Text("Caffeine Tolerance: $caffeineTolerance"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showEditProfileDialog,
              child: Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Edit Profile"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: age?.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Alder",
                ),
                onChanged: (value) {
                  age = int.tryParse(value);
                },
              ),
              TextFormField(
                initialValue: weight?.toString(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Vekt (kg)",
                ),
                onChanged: (value) {
                  weight = int.tryParse(value);
                },
              ),
              DropdownButtonFormField<String>(
                value: caffeineTolerance,
                items: ["Lav", "Moderat", "Høy"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    caffeineTolerance = newValue;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Koffeintolleranse",
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("Avbryt"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (age != null) {
                  userProvider.setUserAge(age!);
                }
                if (weight != null) {
                  userProvider.setUserWeight(weight!);
                }
                if (caffeineTolerance != null) {
                  userProvider.setUserAlcoholTolerance(caffeineTolerance!);
                }
              },
              child: Text("Lagre"),
            ),
          ],
        );
      },
    );
  }
}
