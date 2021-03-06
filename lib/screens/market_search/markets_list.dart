import 'package:crypto_markets/screens/symbol_details/symbol_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:crypto_markets/models/market_model.dart';
import 'package:crypto_markets/services/api_call/api_call.dart';
import 'package:crypto_markets/globals.dart';
import 'bottom_loading_indicator.dart';

class MarketsList extends StatefulWidget {
  MarketsList({Key? key}) : super(key: key);

  final ApiCall apiCall = ApiCall();

  @override
  State<MarketsList> createState() => _MarketsListState();
}

class _MarketsListState extends State<MarketsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MarketModel>(
      future: widget.apiCall.searchMethod(),
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
                    isFetchingMore = true;
                    setState(() {});
                  }
                  print('at the bottom');
                }
              }
              return true;
            },
            child: StatefulBuilder(builder: (context, setState) {
              return AbsorbPointer(
                absorbing: isFetching || isFetchingMore || isFetchingDetails,
                child: Stack(
                  children: [
                    ListView(
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
                                  tappedIndex = index;
                                  isFetchingDetails = true;
                                  setState(() {});
                                  await widget.apiCall
                                      .fetchSymbolContent(index);
                                  await Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DetailsPage(index)));
                                  setState(() {});
                                },
                                leading:
                                    (isFetchingDetails && tappedIndex == index)
                                        ? SizedBox(
                                            height: 40,
                                            width: 40,
                                            child: SpinKitThreeBounce(
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          )
                                        : Text('${index + 1}'),
                                title: Text(content[index]['symbol']),
                                trailing:
                                    Text(content[index]['price'].toString()),
                              ),
                            );
                          },
                          itemCount: content.length,
                        ),
                        if (hasNextPage)
                          SizedBox(
                              height: 40,
                              child: (isFetchingMore && hasNextPage)
                                  ? bottomLoadingIndicator()
                                  : null),
                      ],
                    ),
                    if (isFetching || isFetchingMore)
                      ColoredBox(
                        color: Colors.grey.shade900.withOpacity(0.2),
                        child: Center(
                          child: SpinKitThreeBounce(
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          );
        } else if (snapshot.hasError) {
          return Center(child: (Text('${snapshot.error}')));
        }
        return const Center(
          child: SpinKitThreeBounce(
            color: Colors.white,
            size: 30,
          ),
        );
      },
    );
  }
}
