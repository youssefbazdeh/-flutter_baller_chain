

import 'package:ballerchain/model/player.dart';
import 'package:ballerchain/model/team.dart';

class User {
   String? id;
   String? firstname;
   String? lastname;
   String? email;
   String? birthday;
   String? phonenumber;
   String? password;
   String? image;
   int? coins;
   int? steps;
   Team team;
   static User? _sUser;

  User({
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.birthday,
    this.phonenumber,
    this.password,
    this.image,
    this.coins,
    this.steps,
    required this.team,
  });
  User.test(this.id,this.firstname, this.team);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      birthday: json['birthday'],
      phonenumber: json['phonenumber'],
      password: json['password'],
      image: json['image'],
      coins: json['coins'],
      steps:json['steps'],
      team:Team.empty(1,"",[
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
      ]
      ),
    );
  }
   Map<String, dynamic> toJson() {
     return {
       '_id': id,
       'firstname': firstname,
       'lastname': lastname,
       'email': email,
       'birthday': birthday,
       'phonenumber': phonenumber,
       'password': password,
       'image': image,
       'coins': coins,
       'steps': steps,

     };
   }
   static User? get() {
     if (_sUser == null) {
       _sUser = new User.test("id","first",Team.empty(1,"",[
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
           Player(1,"De Brueyn","Forward",1,"PSG","psg.png",3,1200,80,30,2,25,5,0,0,12,8,0,false,"assets/images/cityy.png"),]));
     }
     return _sUser;
   }
}
