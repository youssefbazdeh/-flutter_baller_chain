import 'package:ballerchain/utils/const.dart';
import 'package:ballerchain/viewModel/player_view_model.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import '../model/playerepl.dart';

class Leagues extends StatefulWidget {
  Leagues({
    Key? key,
    required this.players,
  }) : super(key: key);

  final List<PlayerEPL> players;
  @override
  _LeaguesState createState() => _LeaguesState();
}

class _LeaguesState extends State<Leagues> {
  final PlayerViewModel  _playerViewModel = PlayerViewModel();
  List<PlayerEPL> _playerList = [];
  String? _selectedTeam; // store the selected team value here
  final List<String> _teams = [    'All Clubs',  "Arsenal",
    "Aston Villa",
    "Brentford",
    "Brighton",
    "Bournemouth",
    "Chelsea",
    "Crystal Palace",
    "Everton",
    "Fulham",
    "Leeds",
    "Leicester",
    "Liverpool",
    "Manchester City",
    "Manchester Utd",
    "Newcastle",
    "Nottingham",
    "Southampton",
    "Tottenham",
    "West Ham",
    "Wolves" ];

  String? _selectedPosition; // store the selected team value here
  final List<String> _positions = [    'All Positions',    'Goalkeepers',    'Defenders',    'Midfielders',    'Forwards' ];

  List<PlayerEPL> _searchResult = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getPlayers();
  }

  void _getPlayers() async {
    List<PlayerEPL> players = await _playerViewModel.fetchAllPlayers();
    setState(() {
      _playerList = players;
      _searchResult = players; // initialize search results with all players
    });
  }

  void _filterPlayers() {
    List<PlayerEPL> filteredList = List.from(_playerList);

    if (_selectedTeam != null && _selectedTeam != 'All Clubs') {
      filteredList = filteredList
          .where((player) => player.team == _selectedTeam)
          .toList();
    }


    setState(() {
      _searchResult = filteredList;
    });
  }

  void _onSearchTextChanged(String searchText) {
    if (searchText.isEmpty) {
      setState(() {
        _searchResult = List.from(_playerList); // if search text is empty, show all players
      });
      return;
    }

    setState(() {
      _searchResult = _playerList
          .where((player) =>
          player.name!.toLowerCase().contains(searchText.toLowerCase()))
          .toList(); // filter the player list based on search text
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(height:900 ,width:420 ),
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
                        IconButton(onPressed: (){
                            Navigator.pop(context);
                        }
                        , icon: Icon(Icons.arrow_back),color: Colors.black ),

                        SizedBox(width: 30),
                        Text(
                          'Statistics',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    )
              ),
              Expanded(
                  child: Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade100
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(5),
                      width: double.infinity,
                      height: 47,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(1),

                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextField(
                          controller: _searchController,
                          onChanged: _onSearchTextChanged,
                          decoration: InputDecoration(
                            hintText: 'Search by player name',
                            prefixIcon: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(1),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Club",
                                style: TextStyle(
                                    color: Colors.purpleAccent,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Expanded(
                                child: DropdownButton<String>(
                                  value: _selectedTeam,
                                  items: _teams.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text("All Clubs"),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedTeam = value!;
                                    });
                                    _filterPlayers();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 1),
                        Container(
                          height: 60,
                          width: 200,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(1),
                          ),
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Position",
                                style: TextStyle(
                                    color: Colors.purpleAccent,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Expanded(
                                child: DropdownButton<String>(
                                  value: _selectedPosition,
                                  items: _positions.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  hint: Text("All Players"),
                                  onChanged: (String? value) {
                                    setState(() {
                                      _selectedPosition = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Expanded(child:  Container(
                      height: 650,
                      child:
                      HorizontalDataTable(
                        tableHeight: 650,
                        leftHandSideColumnWidth: 200,
                        rightHandSideColumnWidth: 500,
                        isFixedHeader: true,
                        headerWidgets: _getTitleWidget(),
                        leftSideItemBuilder: _generateFirstColumnRow,
                        rightSideItemBuilder: _generateRightHandSideColumnRow,
                        itemCount: _searchResult.length,
                        rowSeparatorWidget: const Divider(
                          color: Colors.black54,
                          height: 1.0,
                          thickness: 0.0,
                        ),
                        leftHandSideColBackgroundColor: Color(0xFFFFFFFF),
                        rightHandSideColBackgroundColor: Color(0xFFFFFFFF),
                      ),
                    ))

                  ],
                ),
              )
              )
            ],
          ),
      ),
    );
  }
  List<Widget> _getTitleWidget() {
    return [
      _getTitleItemWidget('Player', 100),
      _getTitleItemWidget('Value', 50),
      _getTitleItemWidget('Rating', 50),
      _getTitleItemWidget('Age', 50),
      _getTitleItemWidget('Matches Played', 50),
      _getTitleItemWidget('Goals', 50),
      _getTitleItemWidget('Yellow Cards', 50),
      _getTitleItemWidget('Red Cards', 50),
      _getTitleItemWidget('GW30', 50),
      _getTitleItemWidget('GW30', 50),
      _getTitleItemWidget('GW30', 50),
    ];
  }
  Widget _getTitleItemWidget(String label, double width) {
    return Container(
      child: Text(label, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 10)),
      width: width,
      height: 30,
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      alignment: Alignment.center,
    );
  }
  Widget _generateFirstColumnRow(BuildContext context, int index,) {
    PlayerEPL pla = _searchResult[index];
    String imgpla = pla.image!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Image.asset("assets/images/info.png"),
                width: 13,
                height: 1,
                alignment: Alignment.topRight,
              ),
              Container(
                child: Image.network('$image_url$imgpla'),
                width: 30,
                height: 30,
                alignment: Alignment.centerLeft,
              ),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    pla.name!,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    pla.team!,
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 12),
        ],
      ),
      Container(
        child: Image.asset("assets/images/star.png"),
        width: 13,
        height: 13,
      ),
    ],


    );
  }
  Widget _generateRightHandSideColumnRow(BuildContext context, int index) {
    PlayerEPL pla = _searchResult[index];
    return Row(
      children: <Widget>[
        Container(
          child: Text("£12.1m",style: TextStyle(fontSize: 10)),
          width: 50,
          height: 45,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(pla.rating!.toString(),style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(pla.age!,style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(pla.matches_played!,style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(pla.goals!,style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(pla.yellow_cards!,style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          child: Text(pla.red_cards!,style: TextStyle(fontSize: 10)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.green
          ),
          child: Text("LEE(A)",style: TextStyle(fontSize: 12)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.green
          ),
          child: Text("NFO(H)",style: TextStyle(fontSize: 12)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.grey
          ),
          child: Text("WHU(A)",style: TextStyle(fontSize: 12)),
          width: 50,
          height: 52,
          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
          alignment: Alignment.center,
        ),
      ],
    );
  }
}
