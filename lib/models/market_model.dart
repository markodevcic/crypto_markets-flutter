class MarketModel {
  final List content;
  final bool hasNextPage;
  final int page;
  final int pageSize;
  final int numberOfItems;

  MarketModel({
    required this.content,
    required this.hasNextPage,
    required this.page,
    required this.pageSize,
    required this.numberOfItems,
  });

  getData(json) {
    for (var i in json['items']) {
      MarketModel item = MarketModel(
          content: i['content'],
          hasNextPage: json['meta']['has_next_page'],
          page: json['meta']['page'],
          pageSize: json['meta']['page_size'],
          numberOfItems: json['meta']['number_of_items']);
    }
  }

  factory MarketModel.fromJson(Map<String, dynamic> json) {
    return MarketModel(
      content: json['content'],
      hasNextPage: json['meta']['has_next_page'],
      page: json['meta']['page'],
      pageSize: json['meta']['page_size'],
      numberOfItems: json['meta']['number_of_items'],
    );
  }
}

class SymbolModel {}
