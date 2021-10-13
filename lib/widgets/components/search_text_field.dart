import 'package:flutter/material.dart';

import 'package:crypto_markets/globals.dart';

class SearchTextField extends StatefulWidget {
  SearchTextField({Key? key, required this.showSearchTextField})
      : super(key: key);

  bool showSearchTextField;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  bool showTextFieldIcons = false;
  final bool showProgressIndicator = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: controller,
        onTap: () {},
        onChanged: (value) {
          (value.isEmpty)
              ? showTextFieldIcons = false
              : showTextFieldIcons = true;
          searchText = value;
          setState(() {});
        },
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22),
        decoration: InputDecoration(
            label: const Center(
              child: Text(
                'Search Crypto Markets',
                style: TextStyle(fontSize: 22),
              ),
            ),
            border: null,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            // focusedBorder: OutlineInputBorder(
            //   borderSide: const BorderSide(color: Colors.white54),
            //   borderRadius: BorderRadius.circular(10),
            // ),
            prefixIcon: (showTextFieldIcons)
                ? TextButton(
                    child: const Icon(Icons.clear),
                    onPressed: () {
                      controller.clear();
                      showTextFieldIcons = false;
                      setState(() {});
                    },
                  )
                : null,
            suffixIcon: (showTextFieldIcons)
                ? TextButton(
                    child: const Icon(Icons.search),
                    onPressed: () {},
                  )
                : null),
      ),
    );
  }
}
