import 'package:dating_app/widgets/background_curve_widget.dart';
import 'package:dating_app/widgets/card_stack_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const mainColor = Color(0xFF141466);
const secondColor = Color(0xFF2929CC);
const thirdColor = Color(0xFF6677CC);
const fourthColor = Color(0xFFDADAE6);

void main() {
  runApp(MyApp());
}

//export PATH=~/Documents/flutter/bin:$PATH

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bolig app',
        home: Scaffold(
            backgroundColor: Colors.white,
            body: PageView(
              controller: PageController(),
              scrollDirection: Axis.vertical,
              //pageSnapping: false,
              children: const <Widget>[BackgroundCurveWidget(), FetchApp()],
            )));
  }
}

enum Swipe { left, right, none }
