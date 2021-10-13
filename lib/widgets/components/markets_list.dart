import 'package:flutter/material.dart';

import 'package:crypto_markets/models/market_model.dart';
import 'package:crypto_markets/services/api_call.dart';
import '../../globals.dart';
import 'bottom_loading_indicator.dart';

class MarketsList extends StatefulWidget {
  MarketsList({Key? key}) : super(key: key);

  @override
  State<MarketsList> createState() => _MarketsListState();
}

class _MarketsListState extends State<MarketsList> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FutureBuilder<MarketModel>(
          // future: ApiCall().fetchMarketData(searchText),
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
                        pageNumber++;
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
                            leading: Text('${index + 1}'),
                            title:
                                Text(snapshot.data!.content[index]['symbol']),
                            trailing: Text(snapshot
                                .data!.content[index]['price']
                                .toString()),
                          ),
                        );
                      },
                      itemCount: snapshot.data!.content.length,
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
        )
      ],
    );
  }
}
