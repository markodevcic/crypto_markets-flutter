import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

Widget bottomLoadingIndicator() {
  return SizedBox(
    height: 40,
    child: Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GlowingProgressIndicator(
            child: Text(
              'loading more',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    ),
  );
}
