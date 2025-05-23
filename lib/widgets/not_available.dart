import 'package:flutter/material.dart';

class NotAvailable extends StatelessWidget {
  const NotAvailable({super.key, this.text = 'No Data Found'});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        spacing: 16,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.info_outline,
            size: 64,
            color: Colors.amber,
          ),
          Text(text, maxLines: 5),
        ],
      ),
    );
  }
}
