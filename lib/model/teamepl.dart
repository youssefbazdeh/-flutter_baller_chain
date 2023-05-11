
class TeamEPL {
  String? id;
  String? name;
  String? link;
  String? image;

  TeamEPL({
    this.id,
    this.name,
    this.link,
    this.image});


  factory TeamEPL.fromJson(Map<String, dynamic> json) {
    return TeamEPL(
      id: json['_id'],
      name: json['name'],
      link: json['link'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'link': link,
      'image': image,
    };
  }
}
