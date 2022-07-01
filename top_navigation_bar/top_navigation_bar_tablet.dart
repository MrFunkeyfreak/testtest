import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/widgets/tablet/top_navigation_bar_admin_tablet.dart';
import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/widgets/tablet/top_navigation_bar_scientist_tablet.dart';
import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/widgets/tablet/top_navigation_bar_user_tablet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../provider/auth.dart';
import '../../routing/route_names.dart';

// need to be changed - the difference between desktop and tablet is that here is no Text BestFitnesstrackerEU

final user = FirebaseAuth.instance.currentUser;
var mapUserinformations;
final AuthProvider authProvider = AuthProvider();

// get the user information in form of Map<String, dynamic> from the currentUser email
// input: currentUser email - output: user information in form of Map<String, dynamic>
// used: in FutureBuilder below, to get the role of the current user
Future<Map<String, dynamic>> getCurrentUserEmail() async {    // get the email of the currentUser
  mapUserinformations = await authProvider.getUserByEmailInput(user.email);

  return await mapUserinformations;
}

class TopNavigationBarTablet extends StatelessWidget {

  // using varibale, otherwise authProvider.getUserByEmailInput(user.email) would get called really often -> error
  var currentUserInfos = getCurrentUserEmail();

  @override
  Widget build(BuildContext context) {
    //final authProvider = Provider.of<AuthProvider>(context);  // creating an instance of authProvider

    bool currentRouteIsAdmin = false;
    bool currentRouteIsUser = false;
    bool currentRouteIsScientist = false;

    // checking if an admin, an user or a scientist page is the currentRoute and then set the specific bool value to true
    Navigator.popUntil(context, (currentRoute) {
      if (currentRoute.settings.name == RegristrationScientistRoute || currentRoute.settings.name == RegristrationAdminRoute ||
          currentRoute.settings.name == DashboardRoute || currentRoute.settings.name == UsersAdministrationRoute) {
        currentRouteIsAdmin = true;
      }
      if (currentRoute.settings.name == RegristrationScientistRoute ) {
        currentRouteIsScientist = true;
      }
      if (currentRoute.settings.name == InformationRoute || currentRoute.settings.name == NeuigkeitenRoute ||
          currentRoute.settings.name == AuthenticationPageRoute || currentRoute.settings.name == RegristrationUserRoute ||
          currentRoute.settings.name == ForgotPasswordRoute || currentRoute.settings.name == AccessDeniedRoute) {
        currentRouteIsUser = true;
      }
      // Return true so popUntil() pops nothing.
      return true;
    });

    print('1111111 is null');
    final user = FirebaseAuth.instance.currentUser;
    print('222222222 is null');
    // if currentUser not exist - no user is logged in
    if(user == null) {
      print('user is null');
      mapUserinformations = null;
    } else {         // if currentUser exist
      print('user email: ' + user.email);

      // get the role of the current user - used: check the role of the currentUser and display the right TopNavigationBar
      // input: currentUserInfos (Future of the user information) - output: mapUserinformations in which is stored the role of the current user
      FutureBuilder<Map<String, dynamic>>(
          future: currentUserInfos,
          builder: (_, AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              print('no data');
              if (snapshot.hasError){
                return Text('Something went wrong');
              }
              if(snapshot.hasData){
                print('no data');
                return mapUserinformations=snapshot.data['role'];
              } else {
                print('no data');
              }
            } else {
              return CircularProgressIndicator();
            }
          }
      );
    }

    // current user exist and role is safed in mapUserinformations
    if(mapUserinformations != null){
      print('rolle ist: '+mapUserinformations['role']);

      // specific bool value for user is true and role is user, then create the user TopNavigationBar for user
      // 404_page_not_found Page not found don't have a route, so only the role need to get checked and then the TopNavigationBar for user displayed
      if(currentRouteIsUser == true && mapUserinformations['role'] == 'User'){
        return TopNavigationBarUserTablet();
      } else {
        if (mapUserinformations['role'] == 'User') {
          return TopNavigationBarUserTablet();
        }
      }

      // specific bool value for admin is true and role is admin, then create the user TopNavigationBar for admin
      // 404_page_not_found Page not found don't have a route, so only the role need to get checked and then the TopNavigationBar for admin displayed
      if(currentRouteIsAdmin == true && mapUserinformations['role'] == 'Admin') {
        return TopNavigationBarAdminTablet();
      } else {
        if (mapUserinformations['role'] == 'Admin') {
          return TopNavigationBarAdminTablet();
        }
      }

      // specific bool value for scientist is true and role is scientist, then create the user TopNavigationBar for scientist
      // 404_page_not_found Page not found don't have a route, so only the role need to get checked and then the TopNavigationBar for scientist displayed
      if (currentRouteIsScientist == true && mapUserinformations['role'] == 'Scientist') {
        return TopNavigationBarScientistTablet();
      } else {
        if (mapUserinformations['role'] == 'Scientist') {
          return TopNavigationBarScientistTablet();
        }
      }

      // no user is logged in - currentUser not exist
    } else{
      print('user not logged in');
      return TopNavigationBarUserTablet();
    }
  }
}