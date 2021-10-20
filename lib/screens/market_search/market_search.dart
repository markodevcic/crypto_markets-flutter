import 'package:flutter/material.dart';

import 'markets_list.dart';
import 'package:crypto_markets/globals.dart';

class MarketSearch extends StatefulWidget {
  MarketSearch({Key? key}) : super(key: key);

  static const String id = 'MarketListPage';

  @override
  State<MarketSearch> createState() => _MarketSearchState();
}

class _MarketSearchState extends State<MarketSearch> {
  bool showTextFieldIcons = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
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
                  searchText = value;
                  isFetching = true;
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
                            isFetching = true;
                            searchText = '';
                            pageNumber = 1;
                            showTextFieldIcons = false;
                            FocusManager.instance.primaryFocus!.unfocus();
                            setState(() {});
                          },
                        )
                      : null,
                  suffixIcon: (showTextFieldIcons)
                      ? IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.monetization_on),
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
        body: MarketsList(),
      ),
    );
  }
}
