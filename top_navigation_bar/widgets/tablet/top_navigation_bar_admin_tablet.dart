import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/top_navigation_bar_logo_tablet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../routing/route_names.dart';
import '../../../top_navbar_item/top_navbar_item.dart';


// need to be changed - the difference between desktop and tablet is that here is no Text BestFitnesstrackerEU
// + all the admin/scientist/user difference is missing

final FirebaseAuth auth = FirebaseAuth.instance;

Future<String> currentUserEmail() async {    // get the email of the currentUser
  final String email = await auth.currentUser.email;
  print(email);

  return email;
}

class TopNavigationBarAdminTablet extends StatelessWidget {
  const TopNavigationBarAdminTablet({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SizedBox(width: 15,),
              TopNavBarLogoTablet(),

              Spacer(),      //Space between logo+text and widgets in the center of the row
              TopNavBarItem('Userverwaltung', UsersAdministrationRoute),
              SizedBox(width: 15,),
              TopNavBarItem('Dashboard', DashboardRoute),
              SizedBox(width: 15,),
              TopNavBarItem('Informationen', DashboardRoute),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                  ]
              ),
              SizedBox(width: 15,),
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
                        return Text('eingeloggt als: \n' + snapshot.data,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 10
                            ));
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
                        fontSize: 10
                    )
                ),
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.all(10)),
                ),
              ),
            ]
          ),
        ],
      ),
    );
  }
}