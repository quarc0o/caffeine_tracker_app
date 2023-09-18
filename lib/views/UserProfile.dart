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
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: true);
    UserModel? user = userProvider.user;
    String? name = user?.name ?? "John Doe";
    int? age = user?.age ?? 20;
    int? weight = user?.weight ?? 70;
    CaffeineTolerance? caffeineTolerance =
        user?.tolerance ?? CaffeineTolerance.MEDIUM;

    return Scaffold(
      appBar: AppBar(
        title: Text("Profil"),
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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                padding:
                    EdgeInsets.all(20.0), // Adjust based on your requirement
                decoration: BoxDecoration(
                  color: const Color(
                      0xff0081A7), // This will give it a light blue background
                  borderRadius: BorderRadius.circular(
                      200), // This will make the container round-shaped
                ),
                child: Icon(
                  Icons.person,
                  size: 300,
                  color: Colors.white,
                )),
            SizedBox(height: 20),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.cake, color: Color(0xff0081A7)),
                        SizedBox(width: 10),
                        Text(
                          "Alder: $age",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.fitness_center, color: Color(0xff0081A7)),
                        SizedBox(width: 10),
                        Text(
                          "Weight: ${weight}kg",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.local_cafe, color: Color(0xff0081A7)),
                        SizedBox(width: 10),
                        Text(
                          "Koffeintolleranse: ${caffeineTolerance.description}",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  foregroundColor: Colors.white,
                  backgroundColor:
                      Color(0xffF07167), // This is the color of the text
                ),
                onPressed: () => _showEditProfileDialog(
                    name, age, weight, caffeineTolerance),
                child: Text("Endre opplysninger"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfileDialog(String name, int? age, int? weight,
      CaffeineTolerance? caffeineTolerance) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        bool _isLoading =
            false; // This variable is now local to the builder function

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text("Endre opplysninger"),
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
                    decoration: InputDecoration(
                      labelText: "Koffeintolleranse",
                    ),
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
