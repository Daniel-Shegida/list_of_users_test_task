import 'package:flutter/material.dart';

/// widget of users search empty state, display CircularProgressIndicator
/// if text is empty
class EmptyWidget extends StatelessWidget {
  final String? text;

  const EmptyWidget({this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: text != null
            ? Text(text!)
            : CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
      ),
    );
  }
}
