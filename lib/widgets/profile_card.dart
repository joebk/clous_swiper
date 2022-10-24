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
    return Container(
      height: 580,
      width: 340,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Stack(
        children: [
          Positioned.fill(
            bottom: 50,
            child: InkWell(
              // ON TAP
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
                        height: screenHeight * 0.7,
                        color: Colors.transparent,
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30.0),
                                  topRight: Radius.circular(30.0))),
                          child: Column(
                            children: [
                              Center(
                                child: Column(
                                  children: [
                                    // ignore: prefer_const_constructors
                                    InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Padding(
                                        padding: EdgeInsets.only(right: 15),
                                        child: Align(
                                          alignment: Alignment.bottomRight,
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundColor: Colors.white,
                                            child: Icon(
                                              Icons.close,
                                              color: mainColor,
                                              size: 14,
                                              semanticLabel: 'Luk',
                                              
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0, left: 10, right: 10),
                                      child: Container(
                                        height: 350,
                                        width: double.infinity,
                                        child: PageView(
                                          children: images,
                                          onPageChanged: (index) {
                                            setState(() {
                                              pageIndex = index.toDouble();
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                    DotsIndicator(
                                      dotsCount: widget.house.amountImages,
                                      position: pageIndex,
                                    ),
                                    SizedBox(height: 20,),
                                    ElevatedButton(
                                      child: Text("Se hos mælger", style: TextStyle(fontSize: 14, color: mainColor, fontWeight: FontWeight.bold),),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(horizontal: 20),
                                      ),
                                      onPressed:() {
                                        var url = widget.house.caseUrl;
                                        _launchURL(url);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                    //Modal end
                  },
                );
              },
              //image cliprrect
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  widget.house.imageAsset,
                  fit: BoxFit.fitHeight,
                ),
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
    );
  }
}