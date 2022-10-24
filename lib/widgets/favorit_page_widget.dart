import 'package:dating_app/services/appdata.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/services/appdata.dart';

const mainColor = Color(0xFF141466);
const secondColor = Color(0xFF2929CC);
const thirdColor = Color(0xFF6677CC);
const fourthColor = Color(0xFFDADAE6);

class FavoritPage extends StatefulWidget {
  const FavoritPage({Key? key}) : super(key: key);

  @override
  State<FavoritPage> createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> {
  @override
  var favoritData = appData.favotitter;
  Widget build(BuildContext context) {
    if (favoritData.length > 0) {
      return Column(
        children: [
          //HEADER
          Container(
            height: 100,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: mainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                )),
            child: const SafeArea(
              child: Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text('Favoritter',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white))),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: favoritData.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Container(
                                color: Colors.pink,
                                child: Text(
                                    favoritData[index].name,
                                    // ignore: prefer_const_constructors
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold)
                                        )
                              ),
                              Container(
                                color: Colors.purple,
                                  child: Text(
                                      favoritData[index].pris.toString(),
                                      // ignore: prefer_const_constructors
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)
                                          )
                              ),
                            ],
                          ),
                        )),
                  );
                }),
          )
        ],
      );
    } else {
      return Text('Ingen favoritter');
    }
  }
}

//https://www.youtube.com/watch?v=k1LxTsmAURU&list=PLlvRDpXh1Se5LTJZDrUF9h1_1AT4Raxjd&index=4