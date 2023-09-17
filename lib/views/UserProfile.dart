import 'package:din_koffein/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  CaffeineTolerance? caffeineTolerance = CaffeineTolerance.MEDIUM;

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
        bool _isLoading =
            false; // This variable is now local to the builder function

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
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
                  DropdownButtonFormField<CaffeineTolerance>(
                    value: caffeineTolerance,
                    items:
                        CaffeineTolerance.values.map((CaffeineTolerance value) {
                      return DropdownMenuItem<CaffeineTolerance>(
                        value: value,
                        child: Text(value.description),
                      );
                    }).toList(),
                    onChanged: (CaffeineTolerance? newValue) {
                      if (newValue != null) {
                        setState(() {
                          caffeineTolerance = newValue;
                        });
                      }
                    },
                  )
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
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });
                    if (age != null) {
                      await userProvider.setUserAge(age!);
                    }
                    if (weight != null) {
                      await userProvider.setUserWeight(weight!);
                    }
                    if (caffeineTolerance != null) {
                      await userProvider
                          .setUserAlcoholTolerance(caffeineTolerance!);
                    }
                    Navigator.of(context).pop();
                    Fluttertoast.showToast(msg: "Profil oppdatert!");
                  },
                  child:
                      _isLoading ? CircularProgressIndicator() : Text("Lagre"),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
