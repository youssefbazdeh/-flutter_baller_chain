import 'dart:convert';
import 'package:ballerchain/Utils/const.dart';
import 'package:ballerchain/model/marketplace.dart';
import 'package:ballerchain/model/user_card.dart';
import 'package:http/http.dart' as http;
import '../model/cardd.dart';


class PackViewModel {
  Future<List<Cardd>> generatePack(String userId, int power) async {
    final url = Uri.parse('$base_url/card/pack/$userId/$power');
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Cardd> cards = data.map((card) => Cardd.fromJson(card)).toList();
        return cards;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }


  Future<List<UserCard>> fetchUserCardsById(String user) async {
    final url = Uri.parse('$base_url/card/cards/$user');
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<UserCard> usercards = data.map((c) => UserCard.fromJson(c))
            .toList();
        return usercards;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }


  Future<List<Cardd>> fetchCardById() async {
    final url = Uri.parse('$base_url/card/getCards');
    print(url);

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        List<Cardd> cards = data.map((json) => Cardd.fromJson(json)).toList();
        return cards;
      } else {
        throw Exception('Failed to get users');
      }
    } catch (error) {
      throw error;
    }
  }


  Future<void> addCardToMarketplace(String userId, String cardId, int price) async {
    final url = Uri.parse('$base_url/marketplace/addCard');
    print(url);
    final response = await http.post(
      url,
      body: {
        'user_id': userId,
        'card_id': cardId,
        'price': price.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Card added to marketplace
    } else {
      // Error adding card
    }
  }

  Future<List<Map<String, dynamic>>> getAllCardsFromMarketplace(String filter, {int? minPrice, int? maxPrice}) async {
    var url = Uri.parse('$base_url/marketplace/getCards/$filter');
    if (minPrice != null && maxPrice != null) {
      url = url.replace(queryParameters: {'min': minPrice.toString(), 'max': maxPrice.toString()});
    }
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List<dynamic>;
      final items = data.map((item) => item as Map<String, dynamic>).toList();
      return items;
    } else {
      throw Exception('Failed to load cards from marketplace');
    }
  }



  Future<void> buyCardFromMarketplace(String cardId,String userId) async {
    final url = Uri.parse('$base_url/marketplace/buyCard/$cardId/$userId');

    try {
      final response = await http.get(url);
      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Item purchased successfully
        print(responseData['message']);
      } else {
        // Error occurred
        print(responseData['message']);
      }
    } catch (error) {
      // Handle error
      print('Error occurred while buying card: $error');
    }
  }

}