import 'package:flutter/material.dart';

import '../globals.dart';

class DetailsPage extends StatelessWidget {
  int index;

  DetailsPage(this.index);

  final List symbolKeys = [
    'Symbol',
    'Price change',
    'Price change percent',
    'Weighted average price',
    'Previous close price',
    'Last price',
    'Bid price',
    'Ask price',
    'Open price',
    'High price',
    'Low price',
    'Volume',
    'Open time',
    'Close time',
    'Count'
  ];

  changeRowColor(int index) {
    Color color;
    if (index.isEven) {
      color = Color(0xFF282828);
    } else {
      color = Color(0xFF323232);
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(symbolContent['symbol']),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: symbolContent.length,
        itemBuilder: (context, int index) {
          String value = symbolContent.values.elementAt(index).toString();
          String key = symbolKeys[index];
          return symbolListView(key, value, index);
        },
      ),
    );
  }

  Widget symbolListView(key, value, index) {
    return ColoredBox(
      color: changeRowColor(index),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              key,
              style: TextStyle(fontSize: 16),
            ),
          ),
          Flexible(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
