import 'dart:convert';
import 'package:ballerchain/Utils/const.dart';
import 'package:ballerchain/model/fixture.dart';
import 'package:ballerchain/model/teamepl.dart';
import 'package:http/http.dart' as http;



class FixtureViewModel{
  Future<List<Fixture>> fetchAllFixture() async {
    final url = Uri.parse('$base_url/card/getFixtures');
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Fixture> fixtures = data.map((fixture) => Fixture.fromJson(fixture)).toList();
        return fixtures;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }
}
