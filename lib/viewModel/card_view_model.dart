import 'dart:convert';
import 'package:ballerchain/Utils/const.dart';
import 'package:http/http.dart' as http;

import '../model/cardd.dart';


class CardViewModel{


  Future<List<Cardd>> fetchCardById(String userId) async {
    final url = Uri.parse('$base_url/card/cards/$userId');
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Cardd> cards = data.map((cardd) => Cardd.fromJson(cardd)).toList();
        return cards;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }
}
