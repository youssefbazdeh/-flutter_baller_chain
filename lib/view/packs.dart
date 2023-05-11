import 'package:ballerchain/model/cardd.dart';
import 'package:ballerchain/utils/const.dart';
import 'package:ballerchain/utils/shared_preference.dart';
import 'package:ballerchain/view/profile_page.dart';
import 'package:ballerchain/view/registration.dart';
import 'package:ballerchain/viewModel/pack_view_model.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../common/theme_helper.dart';
import '../model/user_card.dart';
import 'fantasy.dart';
import 'forgot_password_page.dart';
import 'home.dart';
import 'landing_page.dart';
import 'latest.dart';
import 'login.dart';
import 'more.dart';

class Packs extends StatefulWidget {
  @override
  _PacksState createState() => _PacksState();
}

class _PacksState extends State<Packs> {
  PackViewModel _packViewModel = PackViewModel();
  List<Cardd> _packCardList= [];
  List<UserCard> _userCardList= [];
  List<Cardd> _scrapList = [];
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _getUserCards();
    _getScrapCards();
    print(_scrapList.length);
  }

  Future<void> _getUserCards() async {
    SharedPreference.getUserId().then((value) async {
      String? userId = value;
      List<UserCard> userCards = await _packViewModel.fetchUserCardsById(userId!);
      setState(() {
        _userCardList = userCards;
      });
    });

  }

  Future<void> _getScrapCards() async {
      List<Cardd> scrapCards = await _packViewModel.fetchCardById();
      setState(() {
        _scrapList = scrapCards;
      });


  }

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
          Positioned(
            top: 100,
              right: 50,
              left: 50,
              child:
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width:190,
                    decoration:
                    ThemeHelper().buttonBoxDecoration3(context),
                    child: ElevatedButton(
                        style: ThemeHelper().buttonStyle3(),
                        onPressed: () async {
                          SharedPreference.getUserId().then((value) async =>
                          _packCardList = await _packViewModel.generatePack(value!, 100),
                          );
                          // Do something when the button is pressed
                          //Navigator.push(
                          //context,
                          //MaterialPageRoute(builder: (context) => PickTeam(selectedPlayers: playa)),
                          //);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shield_rounded,color:Colors.white),
                            SizedBox(width:10),
                            Text(
                              "Buy Gold Pack",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            )

                          ],
                        )
                    ),
                  ),


                ],
              ),
          ),
          Positioned(
            top: 250,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
              itemCount: _userCardList.length,
              itemBuilder: (BuildContext context, int index) {
                String? cardscr = _userCardList[index].card;
                print(cardscr);
                Cardd cardId = _scrapList.firstWhere((card) => card.id == cardscr);
                String cardname = cardId.name!;
                String cardimg = cardId.image!;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: GestureDetector(
                    onTap: () {
                      String? cardId = cardscr;
                      // Do something with the card ID, such as navigating to a detail screen
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(cardname),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.network('$image_url$cardimg'),
                                ElevatedButton(onPressed: (){
                                  SharedPreference.getUserId().then((value) {
                                    String? userId = value;
                                    String? cardId = _userCardList[index].id!;
                                    print('$userId / $cardId');
                                    _packViewModel.addCardToMarketplace(userId!, cardId, 2000);
                                  });

                                }, child: Text("List for sale"))
                              ],
                            )
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Text('$cardname'),
                        Container(
                          child: Image.network('$image_url$cardimg'),
                          width: 100,
                          height: 100,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
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

