import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../routing/route_names.dart';
import '../../../top_navbar_item/top_navbar_item.dart';
import '../../top_navigation_bar_logo.dart';


final FirebaseAuth auth = FirebaseAuth.instance;

Future<String> currentUserEmail() async {    // get the email of the currentUser
  final String email = await auth.currentUser.email;

  return email;
}

class TopNavigationBarAdminDesktop extends StatelessWidget {
  const TopNavigationBarAdminDesktop({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          SizedBox(width: 30,),
          TopNavBarLogo(),
          SizedBox(width: 15,),
          Visibility(child: Text( "Admin", style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.normal,))),

          Spacer(),      //Space between logo+text and widgets in the center of the row
          TopNavBarItem('Userverwaltung', UsersAdministrationRoute),
          SizedBox(width: 30,),
          TopNavBarItem('Dashboard', DashboardRoute),
          SizedBox(width: 30,),
          TopNavBarItem('Informationen', DashboardRoute),
          SizedBox(width: 30,),
          TopNavBarItem('Neuigkeiten', DashboardRoute),

          Spacer(), //Space between widgets in the center of the row and end of row

          FutureBuilder<String>(     // displaying the email of the current user
              future: currentUserEmail(),
              builder: (_, AsyncSnapshot<String> snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError){
                    return Text('Something went wrong');
                  }
                  if(snapshot.hasData){
                    try {
                      return Text('eingeloggt als: \n' + snapshot.data);
                    } catch (e){ print(e);}
                  }
                } else {
                  return CircularProgressIndicator();
                }
              }
          ),

          SizedBox(width: 10,),

          //sign out the current user - button
          TextButton.icon(
            onPressed: () async => {
              await FirebaseAuth.instance.signOut(),
              print('user ist ausgeloggt'),
              Navigator.of(context).pushNamed(AuthenticationPageRoute),
            },
            icon: Icon(
              IconData(0xe3b3, fontFamily: 'MaterialIcons'),
              color: Colors.black,
              size: 20,
            ),
            label: Text("Logout",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14
                )
            ),
            style: ButtonStyle(
              backgroundColor:
              MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.all(10)),
            ),
          ),
        ],
      ),
    );
  }
}