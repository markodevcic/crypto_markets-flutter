import 'package:crypto_markets/services/datetime_converter.dart';

import '../globals.dart';

class MarketModel {
  late List marketContent;
  late bool nextPage;
  late int page;
  late int pageSize;
  late int numberOfItems;

  MarketModel(
    this.marketContent,
    this.nextPage,
    this.page,
    this.pageSize,
    this.numberOfItems,
  );

  MarketModel.fromJson(Map<String, dynamic> json) {
    marketContent = json['content'];
    nextPage = json['meta']['has_next_page'];
    page = json['meta']['page'];
    pageSize = json['meta']['page_size'];
    numberOfItems = json['meta']['number_of_items'];

    hasNextPage = nextPage;
    if (hasNextPage) pageNumber++;

    for (var i = 0; i < marketContent.length; i++) {
      content.add(marketContent[i]);
    }
  }
}

class SymbolContent {
  Converter converter = Converter();

  SymbolContent.fromJson(Map<String, dynamic> json) {
    Map tempSymbolContent = json['content'];

    tempSymbolContent.forEach(
      (k, v) {
        String key = k[0].toUpperCase() + k.substring(1).toLowerCase();
        key = key.replaceAll('_', ' ');

        if (key == 'Open time' || key == 'Close time') {
          var value = converter.dateTimeConvert(v);
          symbolContent[key] = value;
        } else if (v is double) {
          var value = converter.decimalPlaceFormat(v);
          symbolContent[key] = value;
        } else {
          symbolContent[key] = v;
        }
      },
    );
  }
}
