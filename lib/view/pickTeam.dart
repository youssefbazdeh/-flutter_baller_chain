
import 'package:ballerchain/Utils/const.dart';
import 'package:flutter/material.dart';
import '../common/theme_helper.dart';
import '../model/cardd.dart';
import '../model/player.dart';
import '../model/team.dart';
import '../model/user_card.dart';
import '../viewModel/pack_view_model.dart';
import 'home.dart';



class PickTeam extends StatefulWidget {
  final List<UserCard> selectedPlayers;


  PickTeam({Key? key, required this.selectedPlayers}) : super(key: key);

  @override
  State<PickTeam> createState() => _PickTeamState();
}

class _PickTeamState extends State<PickTeam> {
  PackViewModel _packViewModel = PackViewModel();
  List<Cardd> _scrapList = [];

  List<Map<String, dynamic>> _players = List.generate(4, (index) => {
    'player': null,
    'index': index,
  });

  List<Map<String, dynamic>> _players1 = List.generate(4, (index) => {
    'player': null,
    'index': index,
  });

  List<Map<String, dynamic>> _players2 = List.generate(2, (index) => {
    'player': null,
    'index': index,
  });

  UserCard? _player1;
  int _index1 = 0;
  UserCard? _player2;
  int _index2 = 0;
  UserCard? _player3;
  UserCard? _player4;
  int _index3 = 0;
  UserCard? _player;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _getScrapCards();

  }

  void _onPlayerDragged(UserCard player, int fromIndex, int toIndex) {
    setState(() {
      widget.selectedPlayers.removeAt(fromIndex);
      widget.selectedPlayers.insert(toIndex, player);
    });
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



  Widget Playerview(int index, {UserCard? card}) {
    //print(widget.selectedPlayers.length);
    String? cardscr = widget.selectedPlayers[index].card;
    String? cardId = widget.selectedPlayers[index].id;
    print(index);
    Cardd card = _scrapList.firstWhere((card) => card.id == cardscr);
    String cardname = card.name!;
    String cardimg = card.image!;
    Widget? PlayerVue;
    if (card != null) {PlayerVue = Column(
        children: <Widget>[
          Expanded(
            child: Container(
              width: 70,
              height: 110,
              child: Image.network(
                '$image_url$cardimg',
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(3),
            width: 60,
            height: 17,
            decoration: ThemeHelper().buttonBoxDecoration4(context),
            child: Text(
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
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
            decoration: ThemeHelper().buttonBoxDecoration5(context, "#0000", "#0000"),
            child: Text(
              style: TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
              card.rating!.toString(),
              textAlign: TextAlign.center,
              softWrap: false,
              overflow: TextOverflow.fade,
            ),
          ),
        ],
      );
    }
return Container(
  child: InkWell(
      onTap: () {Navigator.of(context).restorablePush(_dialogBuilder);print(index);} ,
      child: Padding(
          padding: EdgeInsets.only(left: 3.0, right: 3.0), child: PlayerVue
      )
  ),
);
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
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
                        mainAxisAlignment: MainAxisAlignment.end, //players
                        children: <Widget>[
                          Expanded(
                              child: Stack(
                                  children: <Widget>[
                                    Positioned.fill(
                                        child: Image.asset("assets/images/pitch.jpg", fit: BoxFit.fitWidth, alignment: Alignment.bottomCenter,)
                                    ),
                                    Positioned.fill(
                                        child: Image.asset("assets/images/bench.jpg", fit: BoxFit.fitWidth, alignment: Alignment.bottomLeft,)
                                    ),
                                  ]
                              )
                          ),
                        ]
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(20, 38, 20, 2),
                      height: 50,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => print("arrow_back clicked"),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.arrow_back),
                              ),
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
                                      1, (index) => DragTarget(

                                    builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
                                      if (_player != null) {
                                        // A player has been dropped, show the accepted player
                                        var acceptedPlayerView = Playerview(_index, card: _player!);
                                        _index=0;
                                        _player=null;
                                        //print(index);
                                        return acceptedPlayerView;
                                      } else {
                                        // No player is being dragged or dropped, show a default player
                                        return Playerview(index);
                                      }
                                    },
                                    onWillAccept: (data) {
                                      print("onWillAccept: $data");
                                      return true;
                                    },
                                    onAccept: (data) {
                                      print("onAccept: $data");
                                      List<dynamic> dataList = data as List<dynamic>;
                                      UserCard? player = dataList[0];
                                      int indexnv = dataList[1];
                                      setState(() {
                                        //final x = data.asMap();
                                        //List<dynamic> values = x.values.map((value) => value).toList();
                                        _player = player;
                                        _index = indexnv;
                                        print(index);

                                      });
                                    },
                                  ),
                                ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),

                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: EdgeInsets.only(left: 60.0, right: 40.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: List.generate(
                                    4, (index) => DragTarget(
                                    onWillAccept: (data) {
                                      return true;
                                    },
                                    onAccept: (data) {
                                      List<dynamic> dataList = data as List<dynamic>;
                                      UserCard? player = dataList[0] ;
                                      int indexnv = dataList[1];
                                      setState(() {
                                        _players1[index]['player'] = player;
                                        _players1[index]['index'] = indexnv;
                                      });
                                    },
                                    builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
                                      UserCard? player = _players1[index]['player'];
                                      int playerIndex = _players1[index]['index'];
                                      if (player != null) {
                                        return Playerview(playerIndex, card: player);
                                      } else {
                                        return Playerview(index+1);
                                      }
                                    },
                                  ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),

                            Expanded(
                              flex: 6,
                              child: Padding(
                                padding: EdgeInsets.only(left: 60.0, right: 40.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: List.generate(
                                    4, (index) => DragTarget(
                                    onWillAccept: (data) {
                                      return true;
                                    },
                                    onAccept: (data) {
                                      List<dynamic> dataList = data as List<dynamic>;
                                      UserCard? player = dataList[0] ;
                                      int indexnv = dataList[1];
                                      setState(() {
                                        _players[index]['player'] = player;
                                        _players[index]['index'] = indexnv;
                                      });
                                    },
                                    builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
                                      UserCard? player = _players[index]['player'];
                                      int playerIndex = _players[index]['index'];
                                      if (player != null) {
                                        return Playerview(playerIndex, card: player);
                                      } else {
                                        return Playerview(index+7);
                                      }
                                    },
                                  ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),
                            Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 120.0, right: 120.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: List.generate(
                                        2, (index) => DragTarget(
                                      onWillAccept: (data) {
                                        //print("onWillAccept: $data");
                                        return true;
                                      },
                                      onAccept: (data) {
                                        print("onAccept: $data");
                                        List<dynamic> dataList = data as List<dynamic>;
                                        UserCard? player = dataList[0];
                                        int indexnv = dataList[1];
                                        setState(() {
                                          //final x = data.asMap();
                                          //List<dynamic> values = x.values.map((value) => value).toList();
                                          _players2[index]['player'] = player;
                                          _players2[index]['index'] = indexnv;
                                          print(index);

                                        });
                                      },
                                      builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
                                        UserCard? player = _players2[index]['player'];
                                        int playerIndex = _players2[index]['index'];
                                        if (player != null) {
                                          return Playerview(playerIndex, card: player);
                                        } else {
                                          return Playerview(index+12);
                                        }
                                      },
                                    ),
                                    ),
                                  ),
                                )
                            ),
                            Expanded(
                                flex: 4,
                                child: Container()
                            ),
                            Expanded(
                                  flex: 5,
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: List.generate(5, (index) => SubView(player: widget.selectedPlayers[11+index], indexsub: 11+index, scr: _scrapList),
                                    ),
                                  )
                              ),
                            Expanded(
                                flex: 1,
                                child: Container()
                            ),
                          ],
                        ),
                  ],
                )
            )
        );


  }

  static Route<Object?> _dialogBuilder(BuildContext context,
      Object? arguments,) {
    return RawDialogRoute<void>(
        pageBuilder: (BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,) {
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
                                child: Image.asset("assets/images/kdb.png"),
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
                                        "Midfielder",
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
                                    "Kevin De Bruyne",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "Man City",
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
                                      Text("Current",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text("£12.1m",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("Selling",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text("£12.1m",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("Purchase",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text("£12.1m",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("Selected",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text("26.2%",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("GW31",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text("2 pts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("Total",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text("113 pts",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("GW Trans in",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text("7017",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("GW Trans out",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text("6639",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
                                    ]),
                                    SizedBox(width: 10),
                                    Column(children: [
                                      SizedBox(height: 10),
                                      Text("Bonus",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10,color: Colors.black)),
                                      SizedBox(height: 2),
                                      Text("8",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.black))
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
/****************************************** SubView() ******************************************/

class SubView extends StatelessWidget {
  final UserCard player;
  final int indexsub;
  final List<Cardd> scr;


  const SubView({Key? key,  required this.player, required this.indexsub, required this.scr})
      : super(key: key);


  @override
  Widget build(BuildContext context) {

      String? cardscr = player.card;
      Cardd card = scr.firstWhere((card) => card.id == cardscr);
      String img = card.image!;


    return Expanded(
        flex: 1,
        child: GestureDetector(
            onTap: () {
              print(indexsub);
            },
            child: Draggable<List<dynamic>>(
              onDragStarted: (){
                print(indexsub);
              },
              onDragEnd: (details) {
                print("onDragEnd called with details: $details");
              },
              maxSimultaneousDrags: 1,
              data: [player, indexsub] ,
              feedback: Opacity(
                  opacity: 0.5,
                  child: Container(
                      color: Colors.blue,
                      height: 110.0,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Image.network(
                              '$image_url$img',
                              fit: BoxFit.fitHeight,
                            ),
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
                      ))),
              childWhenDragging: Container(),
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      '$image_url$img',
                      fit: BoxFit.fitHeight,
                    ),
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
              ),
            )
        )
    );
  }
}




