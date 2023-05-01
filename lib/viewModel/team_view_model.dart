import 'dart:convert';
import 'package:ballerchain/Utils/const.dart';
import 'package:ballerchain/model/teamepl.dart';
import 'package:http/http.dart' as http;



class TeamViewModel{
  Future<List<TeamEPL>> fetchAllTeams() async {
    final url = Uri.parse('$base_url/card/getTeams');
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<TeamEPL> teams = data.map((teamEPL) => TeamEPL.fromJson(teamEPL)).toList();
        return teams;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }
}
