import 'package:din_koffein/components/DrinkHistory/DrinkScroll.dart';
import 'package:din_koffein/views/AddProductScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../caffeine.dart';
import '../components/Chart.dart';
import '../providers/UserProvider.dart';
import 'UserProfile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _logout() {
    Provider.of<UserProvider>(context, listen: false).signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _navigateToUserSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (contect) => UserProfile(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0081A7),
        leading: IconButton(
          icon: const Icon(
            Icons.person, // This is the user icon.
            color: Colors.white,
          ),
          onPressed: _navigateToUserSettings, // Handle the tap.
          tooltip: 'User Settings',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: Colors.white,
            ),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: MediaQuery.of(context).size.height *
                  0.33, // This occupies 1/3 of the screen height
              color:
                  const Color(0xFF0081A7), // Adjust this to your desired color
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Hei, ${user?.name ?? 'gjest'}!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Velkommen tilbake!',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      Chart(
                        caffeineValues: calculateTotalCaffeineOverTime(
                            user?.drinks ?? [], user!),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height:
                            200, // Adjust this value based on how tall you want the scrolling area to be.
                        child: DrinkScroll(
                          drinks: user.drinks,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddProductScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 50),
                              foregroundColor: Colors.white,
                              backgroundColor: Color(
                                  0xffF07167), // This is the color of the text
                            ),
                            child: Text("Legg til")),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
