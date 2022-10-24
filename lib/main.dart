import 'package:dating_app/widgets/home_page_widget.dart';
import 'package:flutter/material.dart';

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
        theme: ThemeData(
          canvasColor: Colors.transparent,
        ),
        home: const HomePage());
  }
}

enum Swipe { left, right, none }
