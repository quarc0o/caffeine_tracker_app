import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/Chart.dart';
import '../providers/UserProvider.dart';
// ... other imports

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
        backgroundColor: Color(0xFF0081A7),
        title: Text('Home'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Color(0xFF0081A7), // Adjust this to your desired color
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Hello, ${user?.name ?? 'Guest'}!',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Welcome back to our app!',
                      style: TextStyle(color: Colors.white),
                    ),
                    Chart()
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
                // This is the remaining 2/3 of the screen. You can put any other content you want here.
                ),
          ),
        ],
      ),
    );
  }
}
