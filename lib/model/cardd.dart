class Cardd {
  String? id;
  String? team;
  String? jersey_number;
  String? country;
  String? link;
  String? name;
  String? age;
  String? matches_played;
  String? goals;
  String? yellow_cards;
  String? red_cards;
  int? rating;
  String? image;

  Cardd({
    this.id,
    this.team,
    this.jersey_number,
    this.country,
    this.link,
    this.name,
    this.age,
    this.matches_played,
    this.goals,
    this.yellow_cards,
    this.red_cards,
    this.rating,
    this.image
  });

  factory Cardd.fromJson(Map<String, dynamic> json) {
    return Cardd(
    id: json['_id'],
    team: json['team'],
    jersey_number: json['jersey_number'],
    country: json['country'],
    link: json['link'],
    name: json['name'],
    age: json['age'],
    matches_played: json['matches_played'],
    goals: json['goals'],
    yellow_cards: json['yellow_cards'],
    red_cards: json['red_cards'],
    rating: json['rating'],
    image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'team': team,
      'jersey_number': jersey_number,
      'country': country,
      'link': link,
      'name': name,
      'age': age,
      'matches_played': matches_played,
      'goals': goals,
      'yellow_cards': yellow_cards,
      'red_cards': red_cards,
      'rating': rating,
      'image': image,
    };
  }
}
