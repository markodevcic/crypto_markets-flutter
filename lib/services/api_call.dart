import 'package:http/http.dart' show get;
import 'dart:convert';
import 'dart:async';

import 'package:crypto_markets/models/market_model.dart';
import '../constants.dart';
import '../globals.dart';

class ApiCall {
  Future<MarketModel> searchMethod() {
    if (searchText.isNotEmpty) {
      switchApiCall = true;
      return fetchMarketData();
    } else if (searchText.isEmpty) {
      if (switchApiCall) {
        content = [];
        switchApiCall = false;
      }
      return fetchMarketData();
    }
    throw Exception('Failed to search Crypto Markets. Try again.');
  }

  Future<MarketModel> fetchMarketData() async {
    var url = kApiSearchParameter +
        searchText +
        kApiPageNumber +
        pageNumber.toString() +
        '&page_size=30';
    print('Fetch market url: $url');

    var response = await get(Uri.parse(url));
    if (response.statusCode == 200) {
      var decodedJson = json.decode(response.body);

      return MarketModel.fromJson(decodedJson);
    }
    throw Exception('Failed to search Crypto Markets with status code ' +
        response.statusCode.toString());
  }

  Future<SymbolContent> fetchSymbolContent(index) async {
    var symbolUrl = kApi + content[index]['symbol'];
    print('Symbol url: $symbolUrl');

    var symbolResponse = await get(Uri.parse(symbolUrl));
    if (symbolResponse.statusCode == 200) {
      var symbolDecodedJson = json.decode(symbolResponse.body);

      return SymbolContent.fromJson(symbolDecodedJson);
    }
    throw Exception('Failed to search Crypto Markets with status code ' +
        symbolResponse.statusCode.toString());
  }
}
