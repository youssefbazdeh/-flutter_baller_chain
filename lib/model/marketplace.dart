import 'package:ballerchain/model/user_card.dart';

class MarketPlace {
  String id;
  UserCard userCard;
  int price;
  DateTime createdAt;
  DateTime updatedAt;

  MarketPlace({
    required this.id,
    required this.userCard,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MarketPlace.fromJson(Map<String, dynamic> json) {
    return MarketPlace(
      id: json['_id'],
      userCard: UserCard.fromJson(json['user_card']),
      price: json['price'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}




