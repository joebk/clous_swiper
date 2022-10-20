import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dating_app/main.dart';
import 'package:dating_app/model/house.dart';
import 'package:dating_app/widgets/action_button_widget.dart';
import 'package:dating_app/widgets/drag_widget_new.dart';
import 'package:flutter/material.dart';

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
  var response = await http.get(Uri.parse("https://api.prod.bs-aws-stage.com/search/cases?cities=Frederiksberg+C&addressTypes=villa%2Ccondo%2Cterraced+house%2Choliday+house%2Ccooperative%2Cfarm%2Chobby+farm%2Cfull+year+plot%2Cvilla+apartment%2Choliday+plot&per_page=50&page=1&sortAscending=true&sortBy=timeOnMarket"), headers: headers);
  return (json.decode(response.body)['cases'] as List)
      .map((e) => House.fromJson(e))
      .toList();
}

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
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<House>>(
          future: futureHouse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: ValueListenableBuilder(
                      valueListenable: swipeNotifier,
                      builder: (context, swipe, _) => Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: List.generate(snapshot.data!.length, (index) {
                          if (index == snapshot.data!.length - 1) {
                            return PositionedTransition(
                              rect: RelativeRectTween(
                                begin: RelativeRect.fromSize(
                                    const Rect.fromLTWH(0, 0, 800, 640),
                                    const Size(800, 640)),
                                end: RelativeRect.fromSize(
                                    Rect.fromLTWH(
                                        swipe != Swipe.none
                                            ? swipe == Swipe.left
                                                ? -300
                                                : 300
                                            : 0,
                                        0,
                                        800,
                                        640),
                                    const Size(800, 640)),
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
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ActionButtonWidget(
                            onPressed: () {
                              swipeNotifier.value = Swipe.left;
                              _animationController.forward();
                            },
                            icon: const Icon(
                              Icons.close,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 30),
                          ActionButtonWidget(
                            onPressed: () {
                              swipeNotifier.value = Swipe.right;
                              _animationController.forward();
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
                            width: 250.0,
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
                            width: 250.0,
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
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
      );
    }
  }