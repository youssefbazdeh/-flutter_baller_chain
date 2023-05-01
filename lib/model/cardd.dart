class Cardd {
  String? id;
  String? name;
  String? image;
  int? rating;
  String? link;

  Cardd({
    this.id,
    this.name,
    this.image,
    this.rating,
    this.link,
  });

  factory Cardd.fromJson(Map<String, dynamic> json) {
    return Cardd(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      rating: json['rating'],
      link: json['link'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'rating': rating,
      'link': link,
    };
  }
}
