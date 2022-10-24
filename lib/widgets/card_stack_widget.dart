import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dating_app/main.dart';
import 'package:dating_app/model/house.dart';
import 'package:dating_app/widgets/action_button_widget.dart';
import 'package:dating_app/widgets/drag_widget.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/services/appdata.dart';
import 'package:url_launcher/url_launcher.dart';

const mainColor = Color(0xFF141466);
const secondColor = Color(0xFF2929CC);
const thirdColor = Color(0xFF6677CC);
const fourthColor = Color(0xFFDADAE6);

//  Text('Gemt til favoritter',
//      style: TextStyle(
//          fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),

final snackBar = SnackBar(
  content: Row(
    mainAxisSize: MainAxisSize.min,
    // ignore: prefer_const_literals_to_create_immutables
    children: [
      const Text('Gemt til favoritter',
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
      const Icon(Icons.favorite, color: Colors.red, size: 20),
    ],
  ),
  duration: const Duration(seconds: 2),
  backgroundColor: mainColor,
);

_launchURL(url) async {
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

Future<List<House>> fetchHouses() async {
  var headers = {
    'accept': '*/*',
    'accept-language': 'en-GB,en-US;q=0.9,en;q=0.8',
    "cache-control": "no-cache",
    "pragma": "no-cache",
    "sec-fetch-dest": "empty",
    "sec-fetch-mode": "cors",
    "sec-fetch-site": "cross-site",
    "Accept": "application/json"
  };
  var url = appData.text;
  var response = await http.get(
      Uri.parse(
          "https://api.prod.bs-aws-stage.com/search/cases?zipCodes=${url}&addressTypes=villa%2Ccondo%2Cterraced+house%2Choliday+house%2Ccooperative%2Cfarm%2Chobby+farm%2Cfull+year+plot%2Cvilla+apartment%2Choliday+plot&per_page=50&page=1&sortAscending=true&sortBy=timeOnMarket"),
      headers: headers);

  return (json.decode(response.body)['cases'] as List)
      .map((e) => House.fromJson(e))
      .toList();
}

const List<String> list = <String>['One', 'Two', 'Three', 'Four'];

class FetchApp extends StatefulWidget {
  const FetchApp({Key? key}) : super(key: key);

  @override
  State<FetchApp> createState() => _FetchAppState();
}

class _FetchAppState extends State<FetchApp>
    with SingleTickerProviderStateMixin {
  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  late final AnimationController _animationController;

  late Future<List<House>> futureHouse;

  @override
  void initState() {
    super.initState();
    futureHouse = fetchHouses();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
        swipeNotifier.value = Swipe.none;
      }
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<House>>(
      future: futureHouse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: mainColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40.0),
                      bottomRight: Radius.circular(40.0),
                    )),
                child: GestureDetector(
                  onTap: () {
                    print("tapped");
                  },
                  child: const SafeArea(
                    child: Padding(
                        padding: EdgeInsets.only(left: 25),
                        child: Text('Vælg nye filtre',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white))),
                  ),
                ),
              ),
              // Titel Input postnummer
              // Expanded for the rest
              Expanded(
                child: Container(
                    color: Colors.white,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          color: Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: ValueListenableBuilder(
                              valueListenable: swipeNotifier,
                              builder: (context, swipe, _) => Stack(
                                clipBehavior: Clip.none,
                                //alignment: Alignment.center,
                                children: List.generate(snapshot.data!.length,
                                    (index) {
                                  if (index == snapshot.data!.length - 1) {
                                    return PositionedTransition(
                                      rect: RelativeRectTween(
                                        begin: RelativeRect.fromSize(
                                            const Rect.fromLTWH(0, 0, 580, 340),
                                            const Size(580, 340)),
                                        end: RelativeRect.fromSize(
                                            Rect.fromLTWH(
                                                swipe != Swipe.none
                                                    ? swipe == Swipe.left
                                                        ? -300
                                                        : 300
                                                    : 0,
                                                0,
                                                580,
                                                340),
                                            const Size(580, 340)),
                                      ).animate(CurvedAnimation(
                                        parent: _animationController,
                                        curve: Curves.easeInOut,
                                      )),
                                      child: RotationTransition(
                                        turns: Tween<double>(
                                                begin: 0,
                                                end: swipe != Swipe.none
                                                    ? swipe == Swipe.left
                                                        ? -0.1 * 0.3
                                                        : 0.1 * 0.3
                                                    : 0.0)
                                            .animate(
                                          CurvedAnimation(
                                            parent: _animationController,
                                            curve: const Interval(0, 0.4,
                                                curve: Curves.easeInOut),
                                          ),
                                        ),
                                        child: DragWidget(
                                          house: snapshot.data![index],
                                          index: index,
                                          swipeNotifier: swipeNotifier,
                                          isLastCard: true,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return DragWidget(
                                      house: snapshot.data![index],
                                      index: index,
                                      swipeNotifier: swipeNotifier,
                                    );
                                  }
                                }),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 30,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ActionButtonWidget(
                                  onPressed: () {
                                    swipeNotifier.value = Swipe.left;
                                    _animationController.forward().then(
                                      (value) {
                                        snapshot.data!.removeLast();
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                ),
                                const SizedBox(width: 20),
                                ActionButtonWidget(
                                  onPressed: () {
                                    swipeNotifier.value = Swipe.right;
                                    _animationController.forward().then(
                                      (value) {
                                        if (appData.favotitterState.contains(
                                                snapshot.data!.last.name) ==
                                            false) {
                                          appData.favotitter
                                              .add(snapshot.data!.last);
                                        }
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(snackBar);
                                        snapshot.data!.removeLast();
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          child: DragTarget<int>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return IgnorePointer(
                                child: Container(
                                  height: 2000,
                                  width: 80.0,
                                  color: Colors.transparent,
                                ),
                              );
                            },
                            onAccept: (int index) {
                              setState(() {
                                snapshot.data!.removeAt(index);
                              });
                            },
                          ),
                        ),
                        Positioned(
                          right: 0,
                          child: DragTarget<int>(
                            builder: (
                              BuildContext context,
                              List<dynamic> accepted,
                              List<dynamic> rejected,
                            ) {
                              return IgnorePointer(
                                child: Container(
                                  height: 2000.0,
                                  width: 80.0,
                                  color: Colors.transparent,
                                ),
                              );
                            },
                            onAccept: (int index) {
                              setState(() {
                                //var caseUrl = snapshot.data!.last.caseUrl;
                                //_launchURL(caseUrl);
                                if (appData.favotitterState
                                        .contains(snapshot.data!.last.name) ==
                                    false) {
                                  appData.favotitter.add(snapshot.data!.last);
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                                snapshot.data!.removeLast();
                              });
                            },
                          ),
                        ),
                      ],
                    )),
              )
            ],
          );
        } else {
          return Column(children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: const BoxDecoration(
                  color: mainColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40.0),
                    bottomRight: Radius.circular(40.0),
                  )),
              child: SafeArea(
                child: Padding(
                    padding: EdgeInsets.only(top: 25, left: 25),
                    child: Text('Vælg nye filtre',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white))),
              ),
            ),
            const SizedBox(height: 200),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Center(
                child: Text('Ingen data for de filtre du har valgt',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black)),
              ),
            )
          ]);
        }
      },
    );
  }
}
