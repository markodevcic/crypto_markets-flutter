import 'package:flutter/material.dart';

import '../globals.dart';

class DetailsPage extends StatelessWidget {
  int index;

  DetailsPage(this.index);

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
        title: Text(symbolContent['Symbol']),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        primary: false,
        itemCount: symbolContent.length,
        itemBuilder: (context, int index) {
          final value = symbolContent.values.elementAt(index);
          final key = symbolContent.keys.elementAt(index);
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
                value.toString(),
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
