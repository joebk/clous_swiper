import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dating_app/widgets/background_curve_widget.dart';
import 'package:dating_app/model/post.dart';
import 'package:dating_app/widgets/cards_stack_widget.dart';
import 'package:dating_app/widgets/fetch_app.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp2());



Future<List<Post>> fetchPost() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Post>((json) => Post.fromMap(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}


class MyApp2 extends StatelessWidget {
  const MyApp2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        body: Stack(
          children: const [
            BackgroudCurveWidget(),
            //CardsStackWidget(),
            FetchApp(),
          ],
        ),
      ),
    );
  }
}

enum Swipe { left, right, none }
