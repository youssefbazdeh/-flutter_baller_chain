

import 'package:ballerchain/model/player.dart';

class Team {
  int _teamId = 0;
  String _name = "";
  String _owner = "";
  double _price = 0.0;
  int _points = 0;
  int _pointsWeek = 0;
  int _defNum = 0;
  int _midNum = 0;
  int _fwdNum = 0;
  List<Player> _players = [
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  ];


  Team(this._teamId, this._name, this._owner, this._price, this._points, this._pointsWeek,
      this._defNum, this._midNum, this._fwdNum, int goalId, int player1Id,
      int player2Id, int player3Id, int player4Id, int player5Id,
      int player6Id, int player7Id, int player8Id, int player9Id,
      int player10Id, int subGoalId, int sub1Id, int sub2Id, int sub3Id,
      int sub4Id) {

  }
  Team.empty(this._teamId,this._name,this._players);

  factory Team.fromJson(Map<String, dynamic> json, int teamId) {
    return Team(teamId, json['name'], json['owner'], double.parse(json['price']), int.parse(json['points']),
        int.parse(json['points_week']), int.parse(json['def_num']), int.parse(json['mid_num']), int.parse(json['fwd_num']),
        int.parse(json['goal']), int.parse(json['player1']), int.parse(json['player2']), int.parse(json['player3']),
        int.parse(json['player4']), int.parse(json['player5']), int.parse(json['player6']), int.parse(json['player7']),
        int.parse(json['player8']), int.parse(json['player9']), int.parse(json['player10']), int.parse(json['sub_goal']),
        int.parse(json['sub1']), int.parse(json['sub2']), int.parse(json['sub3']),int.parse(json['sub4']));
  }

  //the players are from selected list are rearranged to fit the team sturcture
  Team.fromSelectedList(List<Player> players, this._name, this._owner, this._price) :
        _teamId = 0, _points = 0, _pointsWeek = 0, _defNum = 3, _midNum = 4, _fwdNum = 3 {
    _players.add(players[0]);
    _players.add(players[2]);
    _players.add(players[3]);
    _players.add(players[4]);
    _players.add(players[7]);
    _players.add(players[8]);
    _players.add(players[9]);
    _players.add(players[10]);
    _players.add(players[12]);
    _players.add(players[13]);
    _players.add(players[14]);
    _players.add(players[1]);
    _players.add(players[15]);
    _players.add(players[11]);
    _players.add(players[5]);
    _players.add(players[6]);
  }

  factory Team.fromTeamsJson(Map<String, dynamic> json) {
    return Team(int.parse(json['team_id']), json['name'], json['owner'], double.parse(json['price']), int.parse(json['points']),
        int.parse(json['points_week']), int.parse(json['def_num']), int.parse(json['mid_num']), int.parse(json['fwd_num']),
        int.parse(json['goal']), int.parse(json['player1']), int.parse(json['player2']), int.parse(json['player3']),
        int.parse(json['player4']), int.parse(json['player5']), int.parse(json['player6']), int.parse(json['player7']),
        int.parse(json['player8']), int.parse(json['player9']), int.parse(json['player10']), int.parse(json['sub_goal']),
        int.parse(json['sub1']), int.parse(json['sub2']), int.parse(json['sub3']),int.parse(json['sub4']));
  }

  int get fwdNum => _fwdNum;

  int get midNum => _midNum;

  int get defNum => _defNum;

  int get pointsWeek => _pointsWeek;

  int get points => _points;

  double get price => _price;

  String get owner => _owner;

  String get name => _name;

  int get teamId => _teamId;

  set teamId(int value) {
    _teamId = value;
  }

  String playerAt (int index) => players[index].playerID.toString();

  List<Player> get players => _players;

  set fwdNum(int value) {
    _fwdNum = value;
  }

  set midNum(int value) {
    _midNum = value;
  }

  set defNum(int value) {
    _defNum = value;
  }

  shiftPlayersAndInsert(delIndex, insertIndex, player) {
    _players.removeAt(delIndex);
    _players.insert(insertIndex, player);
  }

  int getCurrentWeeklyPoints() {
    int currentWeeklyPoints = 0;
    for (Player player in players) {
      currentWeeklyPoints+=player.pointsWeek!;
    }
    return currentWeeklyPoints;
  }

}