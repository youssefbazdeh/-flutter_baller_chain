
class Fixture {
  String? id;
  String? time;
  String? home_team;
  String? away_team;

  Fixture({
    this.id,
    this.time,
    this.home_team,
    this.away_team});


  factory Fixture.fromJson(Map<String, dynamic> json) {
    return Fixture(
      id: json['_id'],
      time: json['time'],
      home_team: json['home_team'],
      away_team: json['away_team'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'time': time,
      'home_team': home_team,
      'away_team': away_team,
    };
  }
}
