import 'package:flutter/material.dart';
import 'package:dating_app/widgets/background_curve_widget.dart';
import 'package:dating_app/widgets/card_stack_widget.dart';
import 'package:dating_app/widgets/favorit_page_widget.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

const mainColor = Color(0xFF141466);
const secondColor = Color(0xFF2929CC);
const thirdColor = Color(0xFF6677CC);
const fourthColor = Color(0xFFDADAE6);


List<Widget> _widgetOptions = <Widget>[
  PageView(
    controller: PageController(),
    scrollDirection: Axis.vertical,
    children: const<Widget>[
      BackgroundCurveWidget(),
      FetchApp(),
    ],
  ),
  FavoritPage()
  ];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        // ignore: prefer_const_constructors
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                backgroundColor: Colors.white,
                color: Colors.grey,
                tabBackgroundColor: mainColor,
                activeColor: Colors.white,
                padding: const EdgeInsets.all(8),
                haptic: true,
                iconSize: 24,
                textSize: 14,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  const GButton(
                    icon: Icons.home,
                    text: 'Hjem',
                    gap: 8,
                  ),
                  const GButton(
                    icon: Icons.favorite_border,
                    text: 'Favoritter',
                    gap: 8,
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ));
  }
}

//bottomNavigationBar: Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//          child: const GNav(
//            backgroundColor: Colors.white,
//            color: Colors.grey,
//            tabBackgroundColor: mainColor,
//            activeColor: Colors.white,
//            padding: EdgeInsets.all(8),
//            haptic: true,
//            iconSize: 24,
//            textSize: 14,
//            tabs: [
//            GButton(
//              gap: 8,
//              icon: Icons.home,
//              text: 'Hjem',
//            ),
//            GButton(
//              gap: 8,
//              icon: Icons.favorite_border,
//              text: 'Favoritter',
//            )
//          ],
//
//          ),
//        ),