import 'package:ballerchain/model/user.dart';

class UserCard {
  String? id;
  String? card;
  int? niveau;
  int? position;
  String? user;

  UserCard({
    this.id,
    this.card,
    this.niveau,
    this.position,
    this.user,
  });

  factory UserCard.fromJson(Map<String, dynamic> json) {
    return UserCard(
      id: json['_id'],
      card: json['card'],
      niveau: json['niveau'],
      position: json['position'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'card': card,
      'niveau': niveau,
      'position': position,
      'user': user,
    };
  }
}
