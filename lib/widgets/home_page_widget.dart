import 'package:flutter/material.dart';
import 'package:dating_app/widgets/background_curve_widget.dart';
import 'package:dating_app/widgets/card_stack_widget.dart';
import 'package:dating_app/widgets/favorit_page_widget.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

const mainColor = Color(0xFF141466);
const secondColor = Color(0xFF2929CC);
const thirdColor = Color(0xFF6677CC);
const fourthColor = Color(0xFFDADAE6);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1;
  final PageController _pageController = PageController(
    initialPage: 1,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        BackgroundCurveWidget(pageController: _pageController),
        FetchApp(pageController: _pageController),
        FavoritPage(pageController: _pageController)
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  void bottomTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(index, duration: Duration(milliseconds: 1000), curve: Curves.ease);
    });
  }
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
                    icon: Icons.filter_alt_outlined,
                    text: 'Filtre',
                    gap: 8,
                  ),
                  const GButton(
                    icon: Icons.home,
                    text: 'Boliger',
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
                    bottomTapped(index);
                  });
                },
              ),
            ),
          ),
        ),
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Center(
            child: buildPageView(),
          ),
        ));
  }
}
