import 'package:flutter/material.dart';

// TopNavigationBar Logo for tablet

class TopNavBarLogoTablet extends StatelessWidget {
  const TopNavBarLogoTablet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      width: 110,
      child: Image.asset('assets/logo.png'),
    );
  }
}
