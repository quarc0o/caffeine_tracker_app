import 'package:din_koffein/components/DrinkHistory/DrinkScroll.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/Chart.dart';
import '../providers/UserProvider.dart';

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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0081A7),
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.logout),
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
                        'Hello, ${user?.name ?? 'Guest'}!',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Welcome back to our app!',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        height: 100,
                      ),
                      const Chart(),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height:
                            200, // Adjust this value based on how tall you want the scrolling area to be.
                        child: DrinkScroll(),
                      ),
                      ElevatedButton(onPressed: () {}, child: Text("Legg til"))
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: const Text('Additional content can be placed here.'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
