import 'package:flutter/material.dart';
import '../../../../routing/route_names.dart';
import '../../../top_navbar_item/top_navbar_item.dart';
import '../../top_navigation_bar_logo.dart';

class TopNavigationBarUserDesktop extends StatelessWidget {
  const TopNavigationBarUserDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 30,),
          TopNavBarLogo(),
          SizedBox(width: 30,),
          Visibility(child: Text( "TheBestFitnessTracker", style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.normal,))),

          Spacer(),      //Space between logo+text and widgets in the center of the row
          TopNavBarItem('Informationen', InformationRoute),
          SizedBox(width: 30,),
          TopNavBarItem('Neuigkeiten', NeuigkeitenRoute),
          SizedBox(width: 30,),

          Spacer(), //Space between widgets in the center of the row and end of row
          SizedBox(width: 30,),
          TopNavBarItem('Login', AuthenticationPageRoute),
          SizedBox(width: 30,),
          TopNavBarItem('Teilehmer \n werden', RegristrationUserRoute),
          SizedBox(width: 30,),
        ],
      ),
    );
  }
}
