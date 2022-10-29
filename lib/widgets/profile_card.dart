import 'package:dating_app/main.dart';
import 'package:dating_app/model/house.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

final priceFormat = new NumberFormat.currency(locale: "da_DA", symbol: "");

_launchURL(url) async {
  // ignore: deprecated_member_use
  if (await canLaunch(url)) {
    // ignore: deprecated_member_use
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class HouseCard extends StatefulWidget {
  const HouseCard({Key? key, required this.house}) : super(key: key);
  final House house;
  @override
  State<HouseCard> createState() => _HouseCardState();
}

class _HouseCardState extends State<HouseCard> {
  double pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final images = <Widget>[];
    List imageList = widget.house.images;

    for (var i = 0; i < imageList.length; i++) {
      images.add(
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            widget.house.images[i],
            fit: BoxFit.fitHeight,
          ),
        ),
      );
    }

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
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
                        padding:
                            const EdgeInsets.only(top: 0, left: 10, right: 10),
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
                        dotsCount: widget.house.amountImages,
                        position: pageIndex,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Container(
                          child: Text(
                            widget.house.name,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // ROW 1
                          Container(
                            width: screenWidth / 2.25,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                // Pris
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      '${priceFormat.format(int.parse(widget.house.pris.toString()))} kr',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      '${widget.house.perAreaPrice.toString()} kr/m2',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      '${widget.house.monthlyExpense.toString()} kr/md',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      '${widget.house.priceChangePercentage.toString()} % Prisudvikling',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w800,
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
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      '${widget.house.daysOnMarket.toString()} dage - liggetid',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      '${widget.house.m2.toString()} m2',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      '${widget.house.numberOfRooms.toString()} værelser',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w800,
                                        fontSize: 12,
                                        color: mainColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(6),
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      'Opført ${widget.house.yearBuilt.toString()}',
                                      style: const TextStyle(
                                        fontFamily: 'Nunito',
                                        fontWeight: FontWeight.w800,
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
                            top: 15, left: 30, right: 30, bottom: 5),
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
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                          ),
                          onPressed: () {
                            var url = widget.house.caseUrl;
                            _launchURL(url);
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: ElevatedButton(
                          child: const Text(
                            "Luk",
                            style: TextStyle(
                                fontSize: 14,
                                color: mainColor,
                                fontWeight: FontWeight.bold),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade100,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
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
        height: 580,
        width: 340,
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.house.imageAsset,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Positioned(
              bottom: 50,
              child: Container(
                height: 200,
                width: 340,
                decoration: ShapeDecoration(
                  color: mainColor.withOpacity(0.70),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.05),
                      blurRadius: 8,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.house.name.toString(),
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 21,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '${priceFormat.format(int.parse(widget.house.pris.toString()))}DKK',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${widget.house.m2.toString()} m2',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${widget.house.daysOnMarket.toString()} dage - liggetid',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '${widget.house.numberOfRooms.toString()} rum',
                        style: const TextStyle(
                          fontFamily: 'Nunito',
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
