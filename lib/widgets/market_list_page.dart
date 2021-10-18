import 'package:flutter/material.dart';

import 'package:crypto_markets/globals.dart';
import 'package:crypto_markets/widgets/components/markets_list.dart';

class MarketListPage extends StatefulWidget {
  MarketListPage({Key? key}) : super(key: key);

  @override
  State<MarketListPage> createState() => _MarketListPageState();
}

class _MarketListPageState extends State<MarketListPage> {
  bool showSearchTextField = false;
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
                            Icons.monetization_on,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                          // onPressed: () {
                          //   controller.clear();
                          //   showTextFieldIcons = false;
                          //   setState(() {});
                          //   searchText = '';
                          //   pageNumber = 1;
                          //   content = [];
                          // },
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
