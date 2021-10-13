import 'package:flutter/material.dart';

import 'package:crypto_markets/widgets/market_list_page.dart';

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
      // },
      home: MarketList(),
    );
  }
}
