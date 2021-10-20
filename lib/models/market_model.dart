import 'package:crypto_markets/services/datetime_converter.dart';

import '../globals.dart';

class MarketModel {
  late final List marketContent;
  late final bool nextPage;
  late final int numberOfItems;

  MarketModel(
    this.marketContent,
    this.nextPage,
    this.numberOfItems,
  );

  MarketModel.fromJson(Map<String, dynamic> json) {
    marketContent = json['content'];
    nextPage = json['meta']['has_next_page'];
    numberOfItems = json['meta']['number_of_items'];

    itemsNumber = numberOfItems;
    hasNextPage = nextPage;

    if (isInSearchField && pageNumber == 1) {
      content = [];
    } else if (isInSearchField && itemsNumber < (pageNumber - 1) * 30) {
      content = [];
    }

    for (var i = 0; i < marketContent.length; i++) {
      content.add(marketContent[i]);
    }

    if (hasNextPage) pageNumber++;
    isFetching = false;
    isFetchingMore = false;
  }
}

class SymbolContent {
  final Converter converter = Converter();

  SymbolContent.fromJson(Map<String, dynamic> json) {
    final Map tempSymbolContent = json['content'];

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
    isFetching = false;
    isFetchingDetails = false;
  }
}
