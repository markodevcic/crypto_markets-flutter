import 'package:http/http.dart' show get;
import 'dart:convert';
import 'dart:async';

import 'package:crypto_markets/models/market_model.dart';
import 'api_call_constants.dart';
import '../../globals.dart';

class ApiCall {
  Future<MarketModel> searchMethod() {
    if (searchText.isNotEmpty) {
      isInSearchField = true;
      return fetchMarketData();
    } else if (searchText.isEmpty) {
      if (isInSearchField) {
        content = [];
        isInSearchField = false;
      }
      return fetchMarketData();
    }
    throw Exception('Failed to search Crypto Markets. Try again.');
  }

  Future<MarketModel> fetchMarketData() async {
    final url = kUrl +
        kQuerySearchText +
        searchText +
        kQueryPageNumber +
        pageNumber.toString() +
        '&page_size=30';

    final response =
        await get(Uri.parse(url)).timeout(Duration(seconds: 5), onTimeout: () {
      throw 'Connection timeout';
    });
    if (response.statusCode == 200) {
      final decodedJson = json.decode(response.body);

      return MarketModel.fromJson(decodedJson);
    }
    throw Exception('Failed to search Crypto Markets with status code ' +
        response.statusCode.toString());
  }

  Future<SymbolContent> fetchSymbolContent(index) async {
    final symbolUrl = kUrl + content[index]['symbol'];

    final symbolResponse = await get(Uri.parse(symbolUrl))
        .timeout(Duration(seconds: 5), onTimeout: () {
      throw 'Connection timeout';
    });
    if (symbolResponse.statusCode == 200) {
      final symbolDecodedJson = json.decode(symbolResponse.body);

      return SymbolContent.fromJson(symbolDecodedJson);
    }
    throw Exception('Failed to search Crypto Markets with status code ' +
        symbolResponse.statusCode.toString());
  }
}
