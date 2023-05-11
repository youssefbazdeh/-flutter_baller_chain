import 'package:ballerchain/Utils/const.dart';
import 'package:flutter/material.dart';
import '../common/theme_helper.dart';
import '../model/cardd.dart';
import '../model/player.dart';
import '../model/user_card.dart';
import '../viewModel/pack_view_model.dart';

class Test extends StatefulWidget {
  final List<UserCard>? selectedPlayers;

  Test({Key? key, required this.selectedPlayers}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  PackViewModel _packViewModel = PackViewModel();

  List<Cardd> _scrapList = [];
  @override
  void initState() {
    super.initState();
    _getScrapCards();
    print(_scrapList.length);
    print(widget.selectedPlayers);
  }

  Future<void> _getScrapCards() async {
    List<Cardd> scrapCards = await _packViewModel.fetchCardById();
    setState(() {
      _scrapList = scrapCards;
    });


  }

  final double _checkboxHeight = 30.0;
  double _startingBudget = 107.0;
  double _budget = 107.0;
  bool _everyTeam = false,
      _minThreeFreshers = false,
      _maxThreeSameTeam = true,
      _isTeamNameLong = false,
      _buttonEnabled = true;
  String _teamName = "";
  Widget _saveChanges = Text("Press to save changes");


  /*@override
  void initState() {
    Map<int, int> teamCount = {};
    int fresherCount = 0;
    print(widget.selectedPlayers.toString());
    for (Player player in widget.selectedPlayers) {
      if (player != null) {
        _budget -= player.goals!;
        if (player.isFresher) fresherCount++;
        if (teamCount[player.team] == null) {
          teamCount[player.team] = 1;
        } else {
          if (player.team != null) {
            teamCount[player.team] = (teamCount[player.team] ?? 0) + 1;
          }
          if (player.team != null) {
            if (teamCount[player.team]?.compareTo(3) == 1) {
              _maxThreeSameTeam = false;
            }
          }
        }
      }
    }
    _minThreeFreshers = fresherCount >= 3;
    _everyTeam = teamCount.length >= 7;
    super.initState();
  }*/


  emptyPlayer(int index) {
    if (widget.selectedPlayers != null && widget.selectedPlayers!.isNotEmpty) {
      String? cardscr = widget.selectedPlayers![index].card;
      String? cardId = widget.selectedPlayers![index].id;
      print(index);
      Cardd card = _scrapList.firstWhere((card) => card.id == cardscr);
      String cardname = card.name!;
      String cardimg = card.image!;
      Widget playerView;
      if ( card != null) {
        playerView = Column(
          children: <Widget>[
            Expanded(
                child: Container(
                  width: 70,
                  height: 110,
                  child: Image.network(
                    '$image_url$cardimg',
                    fit: BoxFit.scaleDown,
                  ),
                )
            ),
            Container(
              padding: EdgeInsets.all(3),
              width: 60,
              height: 17,
              decoration: ThemeHelper().buttonBoxDecoration4(context),
              child: Text(
                style: TextStyle(color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold),
                card.name!,
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
            Container(
              padding: EdgeInsets.all(3),
              width: 60,
              height: 17,
              decoration: ThemeHelper().buttonBoxDecoration5(
                  context, "#0000", "#0000"),

              child: Text(
                style: TextStyle(color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold),
                card.rating!.toString(),
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        );
        return Expanded(
          child: InkWell(
              onTap: () {
                final cardMap = card.toJson();
                Navigator.of(context).restorablePush(_dialogBuilder, arguments: cardMap);
              },
              child: Padding(
                  padding: EdgeInsets.only(left: 3.0, right: 3.0), child: playerView
              )
          ),
        );
      }else {
        print("hello");
        playerView = Column(
          children: <Widget>[
            Expanded(
                child: Container(
                  width: 70,
                  height: 110,
                  child: Image.asset(
                    "assets/images/cityy.png",
                    fit: BoxFit.scaleDown,
                  ),
                )
            ),
            Container(
              padding: EdgeInsets.all(3),
              width: 60,
              height: 17,
              decoration: ThemeHelper().buttonBoxDecoration4(context),
              child: Text(
                style: TextStyle(color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold),
                "empty",
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
            Container(
              padding: EdgeInsets.all(3),
              width: 60,
              height: 17,
              decoration: ThemeHelper().buttonBoxDecoration5(
                  context, "#0000", "#0000"),

              child: Text(
                style: TextStyle(color: Colors.white,
                    fontSize: 8,
                    fontWeight: FontWeight.bold),
                "NA",
                textAlign: TextAlign.center,
                softWrap: false,
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        );
        return Expanded(
          child: InkWell(
              onTap: () => Navigator.of(context).restorablePush(_dialogBuilder),
              child: Padding(
                  padding: EdgeInsets.only(left: 3.0, right: 3.0), child: playerView
              )
          ),
        );
      }

      // rest of the code
    } else {
      Widget playerView;
      print("hello");
      playerView = Column(
        children: <Widget>[
          Expanded(
              child: Container(
                width: 70,
                height: 110,
                child: Image.asset(
                  "assets/images/cityy.png",
                  fit: BoxFit.scaleDown,
                ),
              )
          ),
          Container(
            padding: EdgeInsets.all(3),
            width: 60,
            height: 17,
            decoration: ThemeHelper().buttonBoxDecoration4(context),
            child: Text(
              style: TextStyle(color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold),
              "empty",
              textAlign: TextAlign.center,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
          Container(
            padding: EdgeInsets.all(3),
            width: 60,
            height: 17,
            decoration: ThemeHelper().buttonBoxDecoration5(
                context, "#0000", "#0000"),

            child: Text(
              style: TextStyle(color: Colors.white,
                  fontSize: 8,
                  fontWeight: FontWeight.bold),
              "NA",
              textAlign: TextAlign.center,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      );
      return Expanded(
        child: InkWell(
            onTap: () {
              Navigator.of(context).restorablePush(_dialogBuilder);

            },
            child: Padding(
                padding: EdgeInsets.only(left: 3.0, right: 3.0), child: playerView
            )
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            body: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/fantasy_bg.png"),
                          fit: BoxFit.fill
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 100, right: 50, left: 50),
                  height: 1,
                  width: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.centerRight,
                      colors: [Colors.grey, Colors.white, Colors.grey],
                      stops: [0.2, 0.5, 1],
                    ),
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 120, right: 50, left: 60),
                  child: Text(
                    "Gameweek 31 Deadline: samedi 15 avr., 11:00",
                    style: TextStyle(fontWeight: FontWeight.normal,
                        fontSize: 13,
                        color: Colors.black),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 150, right: 50, left: 50),
                  height: 1,
                  width: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.centerRight,
                      colors: [Colors.grey, Colors.white, Colors.grey],
                      stops: [0.2, 0.5, 1],
                    ),
                    color: Colors.white,
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(10, 170, 0, 10),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            width: 90,
                            height: 17,
                            decoration: ThemeHelper().buttonBoxDecoration7(
                                context, "#ffff", "#ffff"),
                            child: Text(
                              style: TextStyle(color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                              "Free Transfers",
                              textAlign: TextAlign.center,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            width: 90,
                            height: 17,
                            decoration: ThemeHelper().buttonBoxDecoration6(
                                context),
                            child: Text(
                              style: TextStyle(color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                              "2",
                              textAlign: TextAlign.center,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            width: 90,
                            height: 17,
                            decoration: ThemeHelper().buttonBoxDecoration7(
                                context, "#ffff", "#ffff"),
                            child: Text(
                              style: TextStyle(color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                              "Wildcard",
                              textAlign: TextAlign.center,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            width: 90,
                            height: 17,
                            decoration: ThemeHelper().buttonBoxDecoration6(
                                context),
                            child: Text(
                              style: TextStyle(color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                              "Available",
                              textAlign: TextAlign.center,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            width: 90,
                            height: 17,
                            decoration: ThemeHelper().buttonBoxDecoration7(
                                context, "#ffff", "#ffff"),
                            child: Text(
                              style: TextStyle(color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                              "Cost",
                              textAlign: TextAlign.center,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            width: 90,
                            height: 17,
                            decoration: ThemeHelper().buttonBoxDecoration6(
                                context),
                            child: Text(
                              style: TextStyle(color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                              "0",
                              textAlign: TextAlign.center,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3),
                            width: 90,
                            height: 17,
                            decoration: ThemeHelper().buttonBoxDecoration7(
                                context, "#ffff", "#ffff"),
                            child: Text(
                              style: TextStyle(color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                              "Bank",
                              textAlign: TextAlign.center,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(3),
                            width: 90,
                            height: 17,
                            decoration: ThemeHelper().buttonBoxDecoration6(
                                context),
                            child: Text(
                              style: TextStyle(color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold),
                              "£9,2m",
                              textAlign: TextAlign.center,
                              softWrap: false,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Image.asset("assets/images/pitch.jpg",
                                  fit: BoxFit.fitWidth,
                                  alignment: Alignment.bottomCenter,),
                              )
                            ]
                        )
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start, //players
                  children: <Widget>[
                    Expanded(
                        flex: 13,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.only(left: 120.0, right: 120.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                                2, (index) => emptyPlayer(index)),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              5, (index) => emptyPlayer(index + 2)),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              5, (index) => emptyPlayer(index + 7)),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Expanded(
                        flex: 6,
                        child: Padding(
                          padding: EdgeInsets.only(left: 70.0, right: 70.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                                3, (index) => emptyPlayer(index + 12)),
                          ),
                        )
                    ),
                    Expanded(
                        flex: 1,
                        child: Container()
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      height: 180,
                      decoration: BoxDecoration(
                        //color: Color.fromRGBO(44, 89, 6, 1),
                          image: DecorationImage(
                              image: AssetImage("assets/images/pitchhh.jpg"),
                              fit: BoxFit.fill
                          )
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: 100,
                        decoration: ThemeHelper().buttonBoxDecoration3(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 190,
                              decoration:
                              ThemeHelper().buttonBoxDecoration8(
                                  context, "#4389A2", "#5C258D"),
                              child: ElevatedButton(
                                onPressed: () {

                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_task_sharp,
                                        color: Colors.white),
                                    SizedBox(width: 10,),
                                    Text("Add Player", style: TextStyle(
                                        color: Colors.white, fontSize: 18),)
                                  ],
                                ),
                                style: ThemeHelper().buttonStyle2(),
                              ),
                            ),
                            SizedBox(width: 10),
                            Container(
                              width: 190,
                              decoration:
                              ThemeHelper().buttonBoxDecoration8(
                                  context, "#4389A2", "#5C258D"),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  print("aaaaaaa");
                                },
                                style: ThemeHelper().buttonStyle2(),
                                child: const Text("Next", style: TextStyle(
                                    fontSize: 18, color: Colors.white),),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 38, 20, 2),
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back),
                          SizedBox(width: 30),
                          Text(
                            'Pick Team',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
        )
    );
  }

  static Route<Object?> _dialogBuilder(BuildContext context, Object? arguments) {
    Map<String, dynamic> cardMap = arguments as Map<String, dynamic>;
    Cardd card = Cardd.fromJson(cardMap);
    String img = card.image!;
    return RawDialogRoute<void>(
        pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            ) {
          return Container(
            margin: EdgeInsets.only(top: 340),
            child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    width: 400,
                    height: 520,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/images/fantasy_bg.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close, color: Colors.white),
                    ),),
                  Positioned(
                      top:60,
                      child: SizedBox(
                        height: 200, // Set a fixed height for the row
                        child: SingleChildScrollView(
                          child: Row(
                            children: [
                              Container(
                                color: Colors.transparent,
                                // Added to remove yellow lines
                                height: 180,
                                width: 120,
                                child: Image.network('$image_url$img'),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(3),
                                    width: 80,
                                    height: 25,
                                    decoration:
                                    ThemeHelper().buttonBoxDecoration6(context),
                                    child: Center(
                                      child: Text(
                                        card.country!,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    card.name!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    card.team!,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 10,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                  ),
                  Stack(
                    children: [
                      Positioned(
                          top: 210,
                          left:10,
                          child: Container(
                              width: 380,
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white54
                              ),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("Rating",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text(card.rating.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("Jersey Number",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text(card.jersey_number!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("Age",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text(card.age!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("matches played",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text(card.matches_played!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("goals",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text(card.goals!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("Yellow Cards",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text(card.yellow_cards!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("Red Cards",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text(card.red_cards!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("GW32",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Container(padding:EdgeInsets.all(4),decoration:BoxDecoration(color: Colors.green),child: Text("WOL(H)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black)),)
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("GW33",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Container(padding:EdgeInsets.all(4),decoration:BoxDecoration(color: Colors.green),child: Text("LEE(A)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black)),)
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("GW34",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Container(padding:EdgeInsets.all(4),decoration:BoxDecoration(color: Colors.green),child: Text("EVE(H)",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black)),)
                                    ]),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              )

                          )
                      ),
                      Positioned(
                        top:280,
                        left:10,
                        child:Container(
                          width: 380,
                          decoration:
                          ThemeHelper().buttonBoxDecoration8(
                              context, "#E4E5E6", "#E4E5E6"),
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ThemeHelper().buttonStyle2(),
                            child: const Text("Full Profile", style: TextStyle(
                                fontSize: 18, color: Colors.grey),),
                          ),
                        ),
                      ),
                      Positioned(
                        top:360,
                        left:10,
                        child:Container(
                          width: 380,
                          decoration:
                          ThemeHelper().buttonBoxDecoration8(
                              context, "#a8ff78", "#78ffd6"),
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ThemeHelper().buttonStyle2(),
                            child: const Text("Replace", style: TextStyle(
                                fontSize: 18, color: Colors.white),),
                          ),
                        ),
                      ),
                      Positioned(
                        top:440,
                        left:10,
                        child:Container(
                          width: 380,
                          decoration:
                          ThemeHelper().buttonBoxDecoration8(
                              context, "#5D26C1", "#5D26C1"),
                          child: ElevatedButton(
                            onPressed: () {

                            },
                            style: ThemeHelper().buttonStyle2(),
                            child: const Text("Remove", style: TextStyle(
                                fontSize: 18, color: Colors.white),),
                          ),
                        ),
                      ),
                    ],
                  )
                ]
            ),
          );
        }
    );
  }
}