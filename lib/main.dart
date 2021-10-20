import 'package:crypto_markets/screens/market_search/market_search.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto Market',
      theme: ThemeData.dark(),
      // routes: {
      //   MarketListPage.id: (context) => MarketListPage(),
      //   MarketsList.id: (context) => MarketsList(),
      //   DetailsPage.id: (context) => DetailsPage(tappedIndex),
      // },
      home: MarketSearch(),
    );
  }
}
