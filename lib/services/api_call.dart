import 'package:crypto_markets/models/market_model.dart';
import 'package:crypto_markets/services/datetime_converter.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show get;
import 'dart:convert';
import 'dart:async';

import '../constants.dart';
import '../globals.dart';

class ApiCall {
  Future<MarketModel> fetchMarketData(searchText) async {
    var url = kApiSearchParameter +
        searchText +
        kApiPageNumber +
        pageNumber.toString() +
        '&page_size=30';
    print(url);
    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);

      // print('Current page number: $pageNumber');
      var model = MarketModel.fromJson(decodedJson);

      hasNextPage = model.hasNextPage;
      // print('Has next page after model: $hasNextPage');
      // print('Number of items: ${model.numberOfItems}');
      if (hasNextPage) pageNumber++;
      for (var i = 0; i < model.content.length; i++) {
        content.add(model.content[i]);
      }
      // print(content.length);
      return model;
      // for (int i = 0; i < tempContent.length; i++) {
      //   content.add(tempContent[i]);
      // }
    }
    throw Exception('Failed to search Crypto Markets with status code ' +
        response.statusCode.toString());
  }

  Future fetchSymbolContent(index) async {
    var symbolUrl = kApi + content[index]['symbol'];

    var symbolResponse = await get(Uri.parse(symbolUrl));
    var symbolDecodedJson = json.decode(symbolResponse.body);
    Map tempSymbolContent = symbolDecodedJson['content'];

    tempSymbolContent.forEach((k, v) {
      if (k == 'open_time') {
        var value = DatetimeConverter().convert(v);
        symbolContent[k] = value;
      } else if (k == 'close_time') {
        var value = DatetimeConverter().convert(v);
        symbolContent[k] = value;
      } else {
        symbolContent[k] = v;
      }
    });

    return symbolContent;
  }
}
