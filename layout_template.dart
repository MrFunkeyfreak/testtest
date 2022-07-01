import 'package:bestfitnesstrackereu/widgets/top_navigation_bar/top_navigation_bar_desktop.dart';
import 'package:bestfitnesstrackereu/widgets/top_navigation_drawer/sidemenu_drawer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import '../../widgets/centered_view/centered_view.dart';
import '../../widgets/top_navigation_bar/top_navigation_bar_mobile.dart';
import '../../widgets/top_navigation_bar/top_navigation_bar_tablet.dart';

// LayoutTemplate which is getting used by every page - called in router.dart, when setting the routes
// requires a widget child which is the view/page returned from router.dart (get_PageRoutRoute)
class LayoutTemplate extends StatelessWidget {
  final Widget child1;
  const LayoutTemplate({Key key, @required this.child1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    var screenSize = MediaQuery.of(context).size;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        // if DeviceScreenType = mobile, then return TopNavigationBarMobile (is a sidemenu)
        // sidemenu, because the screen is to small for TopNavigationBar -> responsivness of the website
        appBar: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? TopNavigationBarMobile(scaffoldKey)
            : PreferredSize(preferredSize: Size(screenSize.width, 1000),
                child: sizingInformation.deviceScreenType == DeviceScreenType.tablet
                    ? TopNavigationBarTablet()
                    : TopNavigationBarDesktop()
        ),
        drawer: SideMenuDrawer(),   //drawer of the sidemenu for the mobile screen
        body: CenteredView(
          child: Column(
            children: <Widget>[
              Expanded(
                child: child1,   //The widget child is the view/page returned from the router (get_PageRoutRoute)
              )
            ],
          ),
        ),
      ),
    );
  }
}