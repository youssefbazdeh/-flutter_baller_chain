
import 'package:ballerchain/view/packs.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import '../common/theme_helper.dart';
import 'fantasy.dart';
import 'landing_page.dart';
import 'latest.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  int _selectedIndex = 4;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Image.asset(
            'assets/images/sweatcoin_bg.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),


          SafeArea(
            child: Stack(
              children: [
                // Add your landing page content here

                Positioned(
                  bottom: 10,
                  left: 10,
                  child: Container(
                    decoration: ThemeHelper().buttonBoxDecoration2(context),
                    margin: EdgeInsets.all(10),
                    child: GNav(
                        rippleColor: Colors.deepPurple, // tab button ripple color when pressed
                        hoverColor: Colors.deepPurple, // tab button hover color
                        haptic: true, // haptic feedback
                        tabBorderRadius: 80,
                        curve: Curves.easeOutExpo, // tab animation curves
                        duration: Duration(milliseconds: 500), // tab animation duration
                        gap: 8, // the tab button gap between icon and text
                        color: Colors.white, // unselected icon color
                        activeColor: Colors.white, // selected icon and text color
                        iconSize: 24, // tab button icon size
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // navigation bar padding
                        selectedIndex: _selectedIndex,
                        onTabChange: (index) {
                          setState(() {
                            print(index);
                            _selectedIndex = index;
                          });
                        },
                        tabs: [
                          GButton(
                            icon: Icons.home,
                            text: 'Home',
                            onPressed: () {
                              // Navigate to the Profile interface
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LandingPage()),
                              );
                            },

                          ),
                          GButton(
                            icon: Icons.health_and_safety,
                            text: 'Likes',
                            onPressed: () {
                              // Navigate to the Profile interface
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Latest()),
                              );
                            },
                          ),
                          GButton(
                            icon: Icons.search,
                            text: 'Search',
                            onPressed: () {
                              // Navigate to the Profile interface
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Fantasy()),
                              );
                            },
                          ),
                          GButton(
                            icon: Icons.person_off,
                            text: 'Packs',
                            onPressed: () {
                              // Navigate to the Profile interface
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Packs()),
                              );
                            },
                          ),
                          GButton(
                            icon: Icons.person_2,
                            text: 'test',
                            onPressed: () {
                              // Navigate to the Profile interface
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => More()),
                              );
                            },
                          )
                        ]
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],

      ),
    );
  }
}

