import 'package:flutter/material.dart';
import '../../../../routing/route_names.dart';
import '../../../top_navbar_item/top_navbar_item.dart';
import '../../top_navigation_bar_logo_tablet.dart';

class TopNavigationBarUserTablet extends StatelessWidget {
  const TopNavigationBarUserTablet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(width: 30,),
          TopNavBarLogoTablet(),
          //SizedBox(width: 30,),
          //Visibility(child: Text( "BestFitnesstrackerEU", style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.normal,))),

          Spacer(),      //Space between logo+text and widgets in the center of the row
          TopNavBarItem('Informationen', InformationRoute),
          SizedBox(width: 20,),
          TopNavBarItem('Neuigkeiten', NeuigkeitenRoute),
          SizedBox(width: 20,),

          Spacer(), //Space between widgets in the center of the row and end of row
          SizedBox(width: 40,),
          TopNavBarItem('Login', AuthenticationPageRoute),
          SizedBox(width: 20,),
          TopNavBarItem('Teilehmer \n werden', RegristrationUserRoute),
          SizedBox(width: 40,),
        ],
      ),
    );
  }
}
