import 'package:flutter/material.dart';

// centers the layout/page and sets a maxWidth  - used in layout_template.dart
// input a widget -> the page

class CenteredView extends StatelessWidget {
  final Widget child;
  const CenteredView({Key key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: 70,
          vertical: 60
      ),
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxWidth: 1200
        ),
        child: child,
      ),
    );
  }
}
