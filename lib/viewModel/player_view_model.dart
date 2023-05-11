import 'dart:convert';
import 'package:ballerchain/Utils/const.dart';
import 'package:ballerchain/model/playerepl.dart';
import 'package:http/http.dart' as http;



class PlayerViewModel{
  Future<List<PlayerEPL>> fetchAllPlayers() async {
    final url = Uri.parse('$base_url/card/allPlayers');
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<PlayerEPL> players = data.map((playerEPL) => PlayerEPL.fromJson(playerEPL)).toList();
        return players;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }
}
