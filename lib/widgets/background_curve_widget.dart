import 'package:dating_app/main.dart';
import 'package:flutter/services.dart';
import 'package:dating_app/model/postnumre.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/services/appdata.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
  const BackgroundCurveWidget({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;

  @override
  State<BackgroundCurveWidget> createState() => _BackgroundCurveWidgetState();
}

class _BackgroundCurveWidgetState extends State<BackgroundCurveWidget> {
  String? dropdownvalue;
  PageController? controller;

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

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: FutureBuilder<List<String>>(
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
                        appData.filters = appData.postnr;
                        widget.pageController.animateToPage(1, duration: Duration(milliseconds: 1000), curve: Curves.easeOut);
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
      ),
    );
  }
}


