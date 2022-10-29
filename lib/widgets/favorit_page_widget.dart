import 'package:dating_app/main.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:dating_app/services/appdata.dart';
import 'package:dating_app/widgets/modal_widget.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

const mainColor = Color(0xFF141466);
const secondColor = Color(0xFF2929CC);
const thirdColor = Color(0xFF6677CC);
const fourthColor = Color(0xFFDADAE6);

final priceFormat = NumberFormat.currency(locale: "da_DA", symbol: "");

_launchURL(url) async {
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class FavoritPage extends StatefulWidget {
  const FavoritPage({Key? key, required this.pageController}) : super(key: key);
  final PageController pageController;

  @override
  State<FavoritPage> createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> {
  double pageIndex = 0;

  @override
  var favoritData = appData.favoritter;
  Widget build(BuildContext context) {
    //return clipRrect with images

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
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
            child: GestureDetector(
              onTap: () {
                widget.pageController.animateToPage(1,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOut);
              },
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
          ),
          //Modal
          Expanded(
            child: ListView.builder(
                itemCount: favoritData.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  //Images
                  final images = <Widget>[];
                  List imageList = favoritData[index].images;

                  for (var i = 0; i < imageList.length; i++) {
                    images.add(
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          favoritData[index].images[i],
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    );
                  }

                  //Images END

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            backgroundColor: Colors.transparent,
                            builder: (BuildContext context) {
                              // MODAL
                              return GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  height: screenHeight * 0.80,
                                  color: Colors.transparent,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30.0),
                                            topRight: Radius.circular(30.0))),
                                    child: ListView(
                                      children: [
                                        // ignore: prefer_const_constructors
                                        SizedBox(height: 25),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 0, left: 10, right: 10),
                                          child: SizedBox(
                                            height: 250,
                                            width: double.infinity,
                                            child: PageView(
                                              children: images,
                                              onPageChanged: (value) {
                                                setState(() {
                                                  pageIndex = value.toDouble();
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                        DotsIndicator(
                                          dotsCount:
                                              favoritData[index].amountImages,
                                          position: pageIndex,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Container(
                                            child: Text(
                                              favoritData[index].name,
                                              style: const TextStyle(
                                                fontFamily: 'Nunito',
                                                fontWeight: FontWeight.w800,
                                                fontSize: 21,
                                                color: mainColor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // ROW 1
                                            Container(
                                              width: screenWidth / 2.25,
                                              color: Colors.transparent,
                                              child: Column(
                                                children: [
                                                  // Pris
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: Text(
                                                        '${priceFormat.format(int.parse(favoritData[index].pris.toString()))} kr',
                                                        style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 12,
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: Text(
                                                        '${favoritData[index].perAreaPrice.toString()} kr/m2',
                                                        style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 12,
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: Text(
                                                        '${favoritData[index].monthlyExpense.toString()} kr/md',
                                                        style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 12,
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: Text(
                                                        '${favoritData[index].priceChangePercentage.toString()} % Prisudvikling',
                                                        style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 12,
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            //ROW 2
                                            Container(
                                              width: screenWidth / 2.25,
                                              color: Colors.transparent,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: Text(
                                                        '${favoritData[index].daysOnMarket.toString()} dage - liggetid',
                                                        style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 12,
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: Text(
                                                        '${favoritData[index].m2.toString()} m2',
                                                        style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 12,
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: Text(
                                                        '${favoritData[index].numberOfRooms.toString()} værelser',
                                                        style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 12,
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            6),
                                                    child: Container(
                                                      width: double.infinity,
                                                      child: Text(
                                                        'Opført ${favoritData[index].yearBuilt.toString()}',
                                                        style: const TextStyle(
                                                          fontFamily: 'Nunito',
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          fontSize: 12,
                                                          color: mainColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  //Opført
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15,
                                              left: 30,
                                              right: 30,
                                              bottom: 5),
                                          child: ElevatedButton(
                                            child: const Text(
                                              "Se hos mælger",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: mainColor,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                            ),
                                            onPressed: () {
                                              var url =
                                                  favoritData[index].caseUrl;
                                              _launchURL(url);
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 80),
                                          child: ElevatedButton(
                                            child: const Text(
                                              "Luk",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  color: mainColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  Colors.grey.shade100,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10),
                                            ),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        ),
                                        // Kort

                                        // Section WITH Description

                                        // Tidligere salgspriser

                                        // Markedet i Frederiksberg Kommune

                                        // Images End
                                      ],
                                    ),
                                  ),
                                ),
                              );
                              //Modal end
                            },
                          );
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: mainColor,
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      favoritData[index].imageAsset),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.55),
                                      BlendMode.dstATop),
                                )
                                //color: mainColor,
                                //borderRadius: BorderRadius.circular(20)
                                ),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Column(
                                children: [
                                  Container(
                                      color: Colors.transparent,
                                      width: double.infinity,
                                      child: Text(favoritData[index].name,
                                          // ignore: prefer_const_constructors
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white))),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Container(
                                              color: Colors.transparent,
                                              child: Text(
                                                  '${priceFormat.format(int.parse(favoritData[index].pris.toString()))} kr',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.white))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Container(
                                              color: Colors.transparent,
                                              child: Text(
                                                  '${favoritData[index].m2} m2',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.white))),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8),
                                          child: Container(
                                              color: Colors.transparent,
                                              child: Text(
                                                  '${favoritData[index].daysOnMarket} liggetid',
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.white))),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Container(
                                              color: Colors.transparent,
                                              child: GestureDetector(
                                                  onTap: () {
                                                    setState(() {
                                                      showModalBottomSheet<
                                                              void>(
                                                          isScrollControlled:
                                                              true,
                                                          context: context,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Container(
                                                                height:
                                                                    screenHeight *
                                                                        0.20,
                                                                child:
                                                                    Container(
                                                                  decoration: const BoxDecoration(
                                                                      color: Colors
                                                                          .white,
                                                                      borderRadius: BorderRadius.only(
                                                                          topLeft: Radius.circular(
                                                                              30.0),
                                                                          topRight:
                                                                              Radius.circular(30.0))),
                                                                  child: Center(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsets.only(
                                                                              top: 25,
                                                                              left: 30),
                                                                          child:
                                                                              Container(
                                                                            height:
                                                                                16,
                                                                            width:
                                                                                double.infinity,
                                                                            color:
                                                                                Colors.transparent,
                                                                            child:
                                                                                const Text('Er du helt sikker?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: mainColor)),
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Container(
                                                                              width: screenWidth / 2,
                                                                              color: Colors.transparent,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(15),
                                                                                child: ElevatedButton(
                                                                                  child: const Text(
                                                                                    "luk",
                                                                                    style: TextStyle(fontSize: 14, color: mainColor, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    backgroundColor: Colors.grey.shade100,
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 60),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Container(
                                                                              width: screenWidth / 2,
                                                                              color: Colors.transparent,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.all(15),
                                                                                child: ElevatedButton(
                                                                                  child: const Text(
                                                                                    "Slet",
                                                                                    style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                  style: ElevatedButton.styleFrom(
                                                                                    backgroundColor: mainColor,
                                                                                    padding: const EdgeInsets.symmetric(horizontal: 60),
                                                                                  ),
                                                                                  onPressed: () {
                                                                                    Navigator.pop(context);
                                                                                    setState(() {
                                                                                      appData.favoritter.removeAt(index);
                                                                                    });
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ));
                                                          });
                                                    });
                                                  },
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                  ))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                  );
                }),
          )
        ],
      );
    } else {
      return const Center(child: Text('Ingen favoritter'));
    }
  }
}
