import 'package:flutter/material.dart';

// TopNavigationBar Logo

class TopNavBarLogo extends StatelessWidget {
  const TopNavBarLogo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 150,
      child: Image.asset('assets/logo.png'),
    );
  }
}
