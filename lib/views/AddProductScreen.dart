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
  final List<String> _products = ["Te", "Kaffe", "Energidrikke"];
  String _selectedProduct = "Te";
  int _numberOfCups = 1;
  final TextEditingController _controller = TextEditingController(text: "1");

  int _calculateCaffeineIntake() {
    int caffeineAmountPerCup;
    switch (_selectedProduct) {
      case 'Te':
        caffeineAmountPerCup = 50;
        break;
      case 'Kaffe':
        caffeineAmountPerCup = 95;
        break;
      case 'Energidrikke':
        caffeineAmountPerCup = 80;
        break;
      default:
        caffeineAmountPerCup = 0;
    }
    return caffeineAmountPerCup * _numberOfCups;
  }

  String getImage() {
    if (_selectedProduct == "Te") {
      return "assets/tea.png";
    } else if (_selectedProduct == "Kaffe") {
      return "assets/coffee.png";
    } else {
      return "assets/energy.png";
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Legg til")),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Velg produkt",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              isExpanded: true,
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
            SizedBox(height: 24),
            Center(
              child: Image.asset(
                getImage(),
                width: 200,
                height: 200,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 24),
            Text(
              "Enheter",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enheter',
              ),
              onChanged: (value) {
                setState(() {
                  _numberOfCups = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 24),
            Text(
              'Totalt koffeininntak: ${_calculateCaffeineIntake()} mg',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.blue,
              ),
            ),
            Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),

                  foregroundColor: Colors.white,
                  backgroundColor:
                      Color(0xffF07167), // This is the color of the text
                ),
                onPressed: () {
                  try {
                    userProvider.addDrink(
                        _selectedProduct, _calculateCaffeineIntake());
                    Navigator.pop(context, _calculateCaffeineIntake());
                    Fluttertoast.showToast(
                        msg: "Produkt lagt til",
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
                child: Text("Legg til")),
          ],
        ),
      ),
    );
  }
}
