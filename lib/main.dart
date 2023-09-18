import 'package:din_koffein/providers/UserProvider.dart';
import 'package:din_koffein/views/AddProductScreen.dart';
import 'package:din_koffein/views/HomeScreen.dart';
import 'package:din_koffein/views/authentication/Login.dart';
import 'package:din_koffein/views/authentication/SignUp.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Your App',
        routes: {
          '/home': (context) => HomeScreen(),
          '/login': (context) => Login(),
          '/signup': (context) => SignUp(),
          '/addproduct': (context) => AddProductScreen(),
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: Color(0xff0081A7),
              primary: Color(0xff0081A7),
              secondary: Color(0xff00AFB9),
              onPrimary: Colors.white,
              onSecondary: Colors.white),
          useMaterial3: true,
        ),
        home: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.user != null) {
              return HomeScreen();
            }
            return Login();
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
