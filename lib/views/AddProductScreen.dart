import 'package:barcode_scanner/barcode_scanning_data.dart';
import 'package:barcode_scanner/json/common_data.dart';
import 'package:barcode_scanner/scanbot_barcode_sdk.dart';
import 'package:flutter/material.dart';
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

  // 2. Introduce function to invoke the barcode scanner
  _scanBarcode({bool shouldSnapImage = false}) async {
    final additionalParameters = BarcodeAdditionalParameters(
      minimumTextLength: 3,
      maximumTextLength: 45,
      minimum1DBarcodesQuietZone: 10,
      codeDensity: CodeDensity.HIGH,
    );
    var config = BarcodeScannerConfiguration(
      barcodeImageGenerationType: shouldSnapImage
          ? BarcodeImageGenerationType.VIDEO_FRAME
          : BarcodeImageGenerationType.NONE,
      topBarBackgroundColor: Colors.blueAccent,
      finderLineColor: Colors.red,
      cancelButtonTitle: "Cancel",
      finderTextHint:
          "Please align any supported barcode in the frame to scan it.",
      successBeepEnabled: true,

      // cameraZoomFactor: 1,
      additionalParameters: additionalParameters,
      // see further customization configs ...
      orientationLockMode: OrientationLockMode.NONE,
      //useButtonsAllCaps: true,
    );

    try {
      var result = await ScanbotBarcodeSdk.startBarcodeScanner(config);

      if (result.operationResult == OperationResult.SUCCESS) {
        // TODO handle result
      }
    } catch (e) {
      print(e);
    }
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
            if (_selectedProduct == "energy drink")
              ElevatedButton(
                onPressed: _scanBarcode,
                child: Text("Scan Barcode"),
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
