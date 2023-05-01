import 'package:ballerchain/model/player.dart';
import 'package:flutter/cupertino.dart';

class DataModel extends ChangeNotifier {
  List<Player> _data = [
    Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
    Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
    Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
    Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
    Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),
  ];

  List<Player> get data => _data;

  void updateData(List<Player> newData) {
    _data = newData;
    notifyListeners();
  }
}
