import 'package:ballerchain/utils/const.dart';
import 'package:ballerchain/utils/shared_preference.dart';
import 'package:ballerchain/viewModel/pack_view_model.dart';
import 'package:ballerchain/viewModel/player_view_model.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import '../model/marketplace.dart';
import '../model/playerepl.dart';

class MyPlayers extends StatefulWidget {
  MyPlayers({
    Key? key,
    required this.players,
  }) : super(key: key);

  final List<PlayerEPL> players;
  @override
  _MyPlayersState createState() => _MyPlayersState();
}

class _MyPlayersState extends State<MyPlayers> {
  final PackViewModel  _packViewModel = PackViewModel();


  List<MarketPlace> _marketplaceItems = [];

  @override
  void initState() {
    super.initState();

    _getMarketplaceItems("pricea","","");
    print(_marketplaceItems.length);
  }

  void _getMarketplaceItems(String filter, String minPrice, String maxPrice) async {
    List<MarketPlace> items = [];
    List<dynamic> marketPlaces = await _packViewModel.getAllCardsFromMarketplace(filter);
    marketPlaces.forEach((marketplace) {
      items.add(MarketPlace.fromJson(marketplace));
    });
    setState(() {
      _marketplaceItems = items;
      print(_marketplaceItems.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/fantasy_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: ListView.builder(
          itemCount: _marketplaceItems.length,
          itemBuilder: (BuildContext context, int index) {
            final item = _marketplaceItems[index];
            final id = item.id;
            final userCard = item.userCard.niveau;
            final userCardId = item.userCard.id;
            final price = item.price;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: GestureDetector(
                onTap: () {
                  String? cardId = id;
                  // Do something with the card ID, such as navigating to a detail screen
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Text(cardId),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('$userCardId'),
                              ElevatedButton(onPressed: (){
                                  SharedPreference.getUserId().then((value) {
                                    String? userid = value;
                                    _packViewModel.buyCardFromMarketplace(cardId,userid! );
                                  });

                              }, child: Text("Buy"))
                            ],
                          )
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Text('price : $price'),

                  ],
                ),
              ),
            );
          },
        )
      ),
    );
  }

}
