import 'package:ballerchain/Utils/const.dart';
import 'package:ballerchain/model/fixture.dart';
import 'package:ballerchain/model/teamepl.dart';
import 'package:ballerchain/viewModel/fixture_view_model.dart';
import 'package:ballerchain/viewModel/team_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../common/theme_helper.dart';
import '../model/playerepl.dart';

class Fixtures extends StatefulWidget {
  @override
  _FixturesState createState() => _FixturesState();
}

class _FixturesState extends State<Fixtures> {
  final TeamViewModel  _teamViewModel = TeamViewModel();
  List<TeamEPL> _teamList = [];
  final FixtureViewModel  _fixtureViewModel = FixtureViewModel();
  List<Fixture> _fixtureList = [];
  List<List<Fixture>> fixturesByWeek = [];

  @override
  void initState() {
    super.initState();
    _getTeams();
    _getFixtures();


  }

  void _getTeams() async {
    List<TeamEPL> teams = await _teamViewModel.fetchAllTeams();
    setState(() {
      _teamList = teams;
    });
  }
  void _getFixtures() async {
    List<Fixture> fixtures = await _fixtureViewModel.fetchAllFixture();
    setState(() {
      _fixtureList = fixtures;
    });
  }
  PageController _pageController = PageController();
  void _onLeftArrowPressed() {
    if (_pageController.hasClients) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

// handle right arrow press
  void _onRightArrowPressed() {
    if (_pageController.hasClients) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }


//itemCoun




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Stack(
        children: [
          Container(
            constraints: BoxConstraints.expand(height: 900, width: 420),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/fantasy_bg.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Your widgets here
                Container(
                  margin: EdgeInsets.fromLTRB(20, 38, 20, 2),
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back),
                          color: Colors.black),
                      SizedBox(width: 30),
                      Text(
                        'Fixtures & Results',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned.fill(
            top: 100,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[100],
                          ),
                          child: IconButton(
                            onPressed: () {
                              // handle left arrow press
                               _onLeftArrowPressed;

                            },
                            icon: Icon(Icons.arrow_left),
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          'Upcoming Fixtures',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue[100],
                          ),
                          child: IconButton(
                            onPressed: () {
                              // handle right arrow press
                              _onRightArrowPressed;

                            },
                            icon: Icon(Icons.arrow_right),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _fixtureList.length, // replace with your actual item count
                      itemBuilder: (BuildContext context, int index) {
                        final DateFormat formatter = DateFormat('dd.MM. HH:mm');
                        Fixture fixture = _fixtureList[index];
                        String time = fixture.time!;
                        DateTime matchDateTime = formatter.parse(time);
                        final DateFormat timeFormatter = DateFormat('HH:mm');
                        String matchTime = timeFormatter.format(matchDateTime);
                        matchDateTime = DateTime(2023, matchDateTime.month, matchDateTime.day, matchDateTime.hour, matchDateTime.minute);
                        DateTime now = DateTime.now();
                        final DateFormat formatter1 = DateFormat('EEEE, d MMM, yyyy');
                        String matchDay = formatter1.format(matchDateTime);
                        String home = fixture.home_team!;
                        String away = fixture.away_team!;
                        TeamEPL homeTeam = _teamList.firstWhere((team) => team.name == home);
                        TeamEPL awayTeam = _teamList.firstWhere((team) => team.name == away);
                        String homeTeamImage = homeTeam.image!;
                        String awayTeamImage = awayTeam.image!;
                        if (matchDateTime.isBefore(now)) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(child:
                                Text('$home',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                ),
                                Expanded(child:
                                Container(
                                  child: Image.network('$image_url$homeTeamImage'),
                                  width: 40,
                                  height: 40,
                                ),
                                ),
                                Expanded(
                                  flex:0,
                                    child:
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: ThemeHelper().buttonBoxDecoration9(context),
                                      child: Text('0',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                )
                                ),
                                SizedBox(width: 5),
                                Expanded(
                                  flex: 0,
                                    child:
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      alignment: Alignment.center,
                                      decoration: ThemeHelper().buttonBoxDecoration9(context),
                                      child: Text('0',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                )
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                  child: Image.network('$image_url$awayTeamImage'),
                                  width: 40,
                                  height: 40,
                                ),
                                ),
                                Expanded(child:
                                Text('$away',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          );
                        }
                        else {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),

                            child: Column(
                              children: [
                                Text('$matchDay'),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(child:
                                    Text('$home',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                    ),
                                    Expanded(child:
                                    Container(
                                      child: Image.network('$image_url$homeTeamImage'),
                                      width: 40,
                                      height: 40,
                                    ),
                                    ),
                                    Expanded(flex:0,
                                        child:
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Container(
                                              width: 85,
                                              height: 40,
                                              alignment: Alignment.center,
                                              decoration: ThemeHelper().buttonBoxDecoration9(context),
                                              child: Text('$matchTime',style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.bold)),
                                            ),
                                          ],
                                        )),

                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Image.network('$image_url$awayTeamImage'),
                                        width: 40,
                                        height: 40,
                                      ),
                                    ),
                                    Expanded(child:
                                    Text('$away',style: TextStyle(fontSize: 11,fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          );

                        }
                      },
                    ),
                  )
                  ,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
