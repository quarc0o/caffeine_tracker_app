import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../providers/UserProvider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final List<String> _products = ["tea", "coffee", "energy drink"];
  String _selectedProduct = "tea";
  int _numberOfCups = 1;
  final TextEditingController _controller = TextEditingController(text: "1");

  int _calculateCaffeineIntake() {
    int caffeineAmountPerCup;
    switch (_selectedProduct) {
      case 'tea':
        caffeineAmountPerCup = 50; // mg of caffeine for tea
        break;
      case 'coffee':
        caffeineAmountPerCup = 95; // mg of caffeine for coffee
        break;
      case 'energy drink':
        caffeineAmountPerCup = 80; // mg of caffeine for energy drink
        break;
      default:
        caffeineAmountPerCup = 0;
    }
    return caffeineAmountPerCup * _numberOfCups;
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Add Product")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedProduct,
              onChanged: (newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedProduct = newValue;
                  });
                }
              },
              items: _products.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  'assets/coffee.png',
                  width: 200,
                  height: 200,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Number of cups',
              ),
              onChanged: (value) {
                setState(() {
                  _numberOfCups = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Total caffeine intake: ${_calculateCaffeineIntake()} mg',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  try {
                    userProvider.addDrink(
                        _selectedProduct, _calculateCaffeineIntake());
                    Navigator.pop(context, _calculateCaffeineIntake());
                    Fluttertoast.showToast(
                        msg: "Product lagt til",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } catch (e) {
                    print(e);
                  }
                },
                child: Text("Add product")),
          ],
        ),
      ),
    );
  }
}
