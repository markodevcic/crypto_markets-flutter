import 'package:flutter/material.dart';

import 'package:crypto_markets/models/market_model.dart';
import 'package:crypto_markets/services/api_call.dart';
import '../globals.dart';
import 'components/bottom_loading_indicator.dart';
import 'details_page.dart';

class MarketList extends StatefulWidget {
  MarketList({Key? key}) : super(key: key);

  @override
  State<MarketList> createState() => _MarketListState();
}

class _MarketListState extends State<MarketList> {
  bool showSearchTextField = false;
  bool showTextFieldIcons = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Expanded(
            child: TextField(
              controller: controller,
              onChanged: (value) {
                (value.isEmpty)
                    ? showTextFieldIcons = false
                    : showTextFieldIcons = true;
                pageNumber = 1;
                content = [];
                searchText = value;
                setState(() {});
              },
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22),
              decoration: InputDecoration(
                label: const Center(
                  child: Text(
                    'Search Crypto Markets',
                    style: TextStyle(fontSize: 22),
                  ),
                ),
                border: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                prefixIcon: (showTextFieldIcons)
                    ? TextButton(
                        child: const Icon(
                          Icons.clear,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          controller.clear();
                          showTextFieldIcons = false;
                          setState(() {});
                          pageNumber = 1;
                          searchText = '';
                          content = [];
                        },
                      )
                    : null,
                suffixIcon: (showTextFieldIcons)
                    ? TextButton(
                        child: const Icon(
                          Icons.refresh,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          controller.clear();
                          showTextFieldIcons = false;
                          setState(() {});
                          searchText = '';
                          pageNumber = 1;
                          content = [];
                        },
                      )
                    : null,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          FutureBuilder<MarketModel>(
            future: ApiCall().fetchMarketData(searchText),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return NotificationListener<ScrollEndNotification>(
                  onNotification: (scrollEnd) {
                    var metrics = scrollEnd.metrics;
                    if (metrics.atEdge) {
                      if (metrics.pixels == 0) {
                        print('at the top');
                      } else {
                        if (hasNextPage) {
                          setState(() {});
                        }
                        print('at the bottom');
                      }
                    }
                    return true;
                  },
                  child: ListView(
                    children: [
                      ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            color: const Color(0xFF323232),
                            elevation: 8,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: ListTile(
                              onTap: () async {
                                await ApiCall().fetchSymbolContent(index);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailsPage(index)));
                              },
                              leading: Text('${index + 1}'),
                              title: Text(content[index]['symbol']),
                              trailing:
                                  Text(content[index]['price'].toString()),
                            ),
                          );
                        },
                        itemCount: content.length,
                      ),
                      if (hasNextPage && pageNumber != 1)
                        bottomLoadingIndicator(),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: (Text('${snapshot.error}')));
              }
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
