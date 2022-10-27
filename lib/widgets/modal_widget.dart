import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:dating_app/services/appdata.dart';

const mainColor = Color(0xFF141466);
const secondColor = Color(0xFF2929CC);
const thirdColor = Color(0xFF6677CC);
const fourthColor = Color(0xFFDADAE6);

class ModalWidget extends StatefulWidget {
  const ModalWidget({Key? key, required this.context_something, required this.index_favorit})
      : super(key: key);
  final BuildContext context_something;
  final int index_favorit;

  @override
  State<ModalWidget> createState() => _ModalWidgetState();
}

class _ModalWidgetState extends State<ModalWidget> {
  @override
  Widget build(BuildContext context) {
    //var context = widget.context_something;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
        height: screenHeight * 0.2,
        child: Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 30),
                  child: Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.transparent,
                    child: const Text('Er du helt sikker?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: mainColor)),
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: screenWidth / 2,
                      color: Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.all(25),
                        child: ElevatedButton(
                          child: const Text(
                            "luk",
                            style: TextStyle(
                                fontSize: 14,
                                color: mainColor,
                                fontWeight: FontWeight.bold),
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
                              appData.favoritter.removeAt(widget.index_favorit);
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
  }
}
