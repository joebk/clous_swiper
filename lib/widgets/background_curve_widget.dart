import 'dart:ffi';

import 'package:flutter/services.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:dating_app/model/postnumre.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/services/appdata.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

final priceFormat =
    NumberFormat.currency(locale: "da_DA", symbol: "", decimalDigits: 0);

int formatPrice(price) {
  String strip = price.replaceAll('.', '');
  String intprice = strip.split(' ')[0];
  return int.parse(intprice);
}

const mainColor = Color(0xFF141466);
const secondColor = Color(0xFF2929CC);
const thirdColor = Color(0xFF6677CC);
const fourthColor = Color(0xFFDADAE6);

dynamic list = <String>['One', 'Two', 'Three', 'Four'];

Future<Postnumre> fetchPostnumre() async {
  final response =
      await http.get(Uri.parse('https://api.dataforsyningen.dk/postnumre'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    var responseJson = json.decode(response.body);
    // then parse the JSON.
    return responseJson['nr'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class BackgroundCurveWidget extends StatefulWidget {
  const BackgroundCurveWidget({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;

  @override
  State<BackgroundCurveWidget> createState() => _BackgroundCurveWidgetState();
}

class _BackgroundCurveWidgetState extends State<BackgroundCurveWidget> {
  String? dropdownvalue;
  PageController? controller;
  //final minPriceController = TextEditingController(text: '0');
  //final maxPriceController = TextEditingController(text: '15.000.000');
  //RangeValues _currentRangeValues = RangeValues(0, 9000000);

  Future<List<String>> getAllCategory() async {
    var baseUrl = "https://api.dataforsyningen.dk/postnumre";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<String> items = [];
      var jsonData = json.decode(response.body) as List;
      for (var element in jsonData) {
        items.add(element["nr"]);
      }
      return items;
    } else {
      throw response.statusCode;
    }
  }

  //void dispose() {
  //  // Clean up the controller when the widget is removed from the
  //  // widget tree.
  //  maxPriceController.dispose();
  //  minPriceController.dispose();
  //  super.dispose();
  //}

  @override
  Widget build(BuildContext context) {
    double _maxPriceChosen = appData.maxPriceChosen;
    double _minPriceChosen = appData.minPriceChosen;
    RangeValues _currentRangeValues = RangeValues(_minPriceChosen, _maxPriceChosen);
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return FutureBuilder<List<String>>(
      future: getAllCategory(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data!;
          return Container(
            color: mainColor,
            child: SafeArea(
                child: Center(
                    child: Column(
              children: [
                // CLOUS NAVN
                const Text('Clous',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white)),
                const SizedBox(height: 30),

                // Titel Input postnummer
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                      height: 30,
                      width: double.infinity,
                      child: const Text('Vælg postnumre',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white))),
                ),

                //Dropdown
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: DropdownButtonFormField(
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        value: appData.postnr,
                        style: const TextStyle(
                            color: mainColor, fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                            border: InputBorder.none,
                            iconColor: mainColor,
                            focusColor: mainColor,
                            hoverColor: mainColor),
                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),
                        // Array list of items
                        items: data.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                            appData.postnr = dropdownvalue.toString();
                          });
                        },
                      ),
                    ),
                  ),
                ),
                // Titel Input Pris
                Padding(
                  padding: const EdgeInsets.only(left: 25, right: 25, top: 15),
                  child: Container(
                      height: 30,
                      width: double.infinity,
                      child: const Text('Vælg min og max pris i DKK',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.white))),
                ),
                RangeSlider(
                  values: _currentRangeValues,
                  max: 20000000,
                  min: 0,
                  activeColor: Colors.white,
                  inactiveColor: Colors.grey,
                  divisions: 200,
                  //labels: RangeLabels(
                  //  "${priceFormat.format(int.parse(_currentRangeValues.start.round().toString()))} kr",
                  //  //"${_currentRangeValues.start.round().toString()} DKK",
                  //  "${priceFormat.format(int.parse(_currentRangeValues.end.round().toString()))} kr",
                  //  //"${_currentRangeValues.end.round().toString()} DKK",
                  //),
                  onChanged: (RangeValues values) {
                    setState(() {
                      _currentRangeValues = values;
                      appData.minPriceChosen = values.start;
                      appData.maxPriceChosen = values.end;
                    });
                  },
                ),
                // Min-max values shown in text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                          color: Colors.transparent,
                          child: Text("${priceFormat.format(int.parse(_currentRangeValues.start.round().toString()))} kr".toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                          color: Colors.transparent,
                          child: Text("${priceFormat.format(int.parse(_currentRangeValues.end.round().toString()))} kr".toString(),
                              style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                // Opdater filtre
                ElevatedButton(
                  child: const Text(
                    "Opdater filtre",
                    style: TextStyle(
                        fontSize: 14,
                        color: mainColor,
                        fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                  onPressed: () {
                    setState(() {
                      appData.filters['postnr'] = appData.postnr;
                      appData.filters['minPrice'] = _minPriceChosen.round();
                      appData.filters['maxPrice'] = _maxPriceChosen.round();
                      widget.pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 1000),
                          curve: Curves.easeOut);
                    });
                  },
                ),

                // Next Filter
              ],
            ))),
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(color: Colors.white));
        }
      },
    );
  }
}

//Row(
//  mainAxisAlignment: MainAxisAlignment.center,
//  crossAxisAlignment: CrossAxisAlignment.center,
//  children: [
//    Padding(
//      padding: const EdgeInsets.only(
//          left: 15, right: 15, top: 0, bottom: 5),
//      child: Container(
//        width: screenWidth / 2.5,
//        decoration: BoxDecoration(
//            color: Colors.white,
//            border: Border.all(color: Colors.white),
//            borderRadius: BorderRadius.circular(12)),
//        child: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 20),
//          child: TextField(
//            inputFormatters: [
//              FilteringTextInputFormatter.digitsOnly,
//              LengthLimitingTextInputFormatter(9),
//              CurrencyTextInputFormatter(
//                locale: 'da',
//                decimalDigits: 0,
//                symbol: '',
//              ),
//            ],
//            keyboardType: TextInputType.number,
//            controller: minPriceController,
//            style: const TextStyle(
//                color: mainColor,
//                fontWeight: FontWeight.bold,
//                fontSize: 12),
//            decoration: const InputDecoration(
//              border: InputBorder.none,
//              iconColor: mainColor,
//              focusColor: mainColor,
//              hoverColor: mainColor,
//              hintText: '2.000.000 DKK',
//            ),
//          ),
//        ),
//      ),
//    ),
//    Padding(
//      padding: const EdgeInsets.only(
//          left: 15, right: 15, top: 0, bottom: 5),
//      child: Container(
//        width: screenWidth / 2.5,
//        decoration: BoxDecoration(
//            color: Colors.white,
//            border: Border.all(color: Colors.white),
//            borderRadius: BorderRadius.circular(12)),
//        child: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 20),
//          child: TextField(
//            inputFormatters: [
//              FilteringTextInputFormatter.digitsOnly,
//              LengthLimitingTextInputFormatter(9),
//              CurrencyTextInputFormatter(
//                locale: 'da',
//                decimalDigits: 0,
//                symbol: '',
//              ),
//            ],
//            controller: maxPriceController,
//            style: const TextStyle(
//                color: mainColor,
//                fontWeight: FontWeight.bold,
//                fontSize: 12),
//            decoration: const InputDecoration(
//              border: InputBorder.none,
//              iconColor: mainColor,
//              focusColor: mainColor,
//              hoverColor: mainColor,
//              hintText: '4.500.000 DKK',
//            ),
//          ),
//        ),
//      ),
//    ),
//  ],
//),
