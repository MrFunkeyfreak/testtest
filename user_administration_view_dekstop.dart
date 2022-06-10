import 'package:bestfitnesstrackereu/pages/user_administration/widgets/edit_button_admin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';
import '../../provider/auth.dart';
import '../../provider/users_table.dart';
import '../../routing/route_names.dart';
import 'package:bestfitnesstrackereu/routing/route_names.dart';


class UsersAdministrationViewDesktop extends StatefulWidget {
  UsersAdministrationViewDesktop({Key key}) : super(key: key);

  @override
  _UsersAdministrationViewDesktopState createState() => _UsersAdministrationViewDesktopState();
}

class _UsersAdministrationViewDesktopState extends State<UsersAdministrationViewDesktop> {

  final user = FirebaseAuth.instance.currentUser;  //check if user is logged in
  String uid;
  List<Map<String, dynamic>> selectedRow;
  AuthProvider authproviderInstance = AuthProvider();



  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final UsersTable userTable = Provider.of<UsersTable>(context);

    return Scaffold(
      appBar: AppBar(
          title: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text("Admin-Menü", style: TextStyle(color: Colors.white)),
                SizedBox(width: 300,),
                Text("Benutzerverwaltung"),
                Spacer(),
                IconButton(icon: Icon(Icons.refresh_sharp),
                  onPressed: userTable.initializeData,
                ),
              ]
          )
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.storage),
              title: Text("Benutzerverwaltung"),
              onTap: () {
                Navigator.of(context).pushNamed(UsersAdministrationRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.storage),
              title: Text("Wissenschaftlerverwaltung"),
              onTap: () {
                Navigator.of(context).pushNamed(UsersAdministrationRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.storage),
              title: Text("Adminverwaltung"),
              onTap: () {
                Navigator.of(context).pushNamed(UsersAdministrationRoute);
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Dashboard"),
              onTap: () {
                Navigator.of(context).pushNamed(DashboardRoute);
              },
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(0),
                  constraints: BoxConstraints(
                    maxHeight: 700,
                  ),
                  child: Card(
                    elevation: 1,
                    shadowColor: Colors.black,
                    clipBehavior: Clip.none,
                    child: ResponsiveDatatable(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Wrap(
                            children: <Widget>[

                              //add user to the list
                              TextButton.icon(
                                onPressed: () => {
                                  Navigator.of(context).pushNamed(RegristrationAdminRoute)
                                  //Pop-up Fenster für die Registration machen, wenn Zeit - ansonsten registrationsfenster weiterleiten
                                },
                                icon: Icon(Icons.add, color: Colors.black,),
                                label: Text("Hinzufügen",
                                    style: TextStyle(
                                        color: Colors.black
                                    )
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.all(10)),
                                ),
                              ),

                              SizedBox(width: 15,),

                              //edit-button + functionality

                              EditButtonAdmin(),

                              SizedBox(width: 15,),

                              TextButton.icon(
                                onPressed: () async => {
                                  selectedRow = userTable.selecteds,
                                  if(selectedRow.isEmpty){
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Error: Bitte wähle einen User aus."),
                                        actions: [
                                          TextButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    })
                                  },

                                  if(selectedRow.length == 1){
                                    uid = selectedRow[0]['uid'],
                                    await AuthProvider.deleteUser(uid),
                                    print(uid + 'user gelöscht')
                                  },

                                  if(selectedRow.length >= 2) {
                                    //die uid von allen in der Liste durchgehen und rolle ändern
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Error: Bitte wähle genau einen User aus."),
                                        actions: [
                                          TextButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    })
                                  }

                                },
                                icon: Icon(
                                  IconData(0xe1bb, fontFamily: 'MaterialIcons'),
                                  color: Colors.black,
                                ),
                                label: Text("Löschen",
                                    style: TextStyle(
                                        color: Colors.black
                                    )
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.all(10)),
                                ),
                              ),

                              ],),

                          SizedBox(height: 10,),

                          Wrap (
                            children: [
                              TextButton.icon(
                                onPressed: () async => {
                                  selectedRow = userTable.selecteds,

                                  if(selectedRow.isEmpty){
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Error: Bitte wähle einen User aus."),
                                        actions: [
                                          TextButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    })
                                  },

                                  if(selectedRow.length == 1){
                                    uid = selectedRow[0]['uid'],
                                    await authproviderInstance.updateUserStatus(uid, 'gesperrt'),
                                  },

                                  if(selectedRow.length >= 2) {
                                    //die uid von allen in der Liste durchgehen und rolle ändern

                                    for (var i=0; i<selectedRow.length;i++){ //für alle uids in der Liste
                                      await authproviderInstance.updateUserStatus(selectedRow[i]['uid'], 'gesperrt'),
                                    },
                                  },
                                  userTable.selecteds.clear(),
                                  userTable.initializeData(),

                                },
                                icon: Icon(
                                  IconData(0xe3b1, fontFamily: 'MaterialIcons'),
                                  color: Colors.black,
                                ),
                                label: Text("Sperren",
                                    style: TextStyle(
                                        color: Colors.black
                                    )
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.all(10)),
                                ),
                              ),

                              SizedBox(width: 15,),

                              TextButton.icon(
                                onPressed: () async => {

                                  selectedRow = userTable.selecteds,
                                  if(selectedRow.isEmpty){
                                    showDialog(context: context, builder: (BuildContext context){
                                      return AlertDialog(
                                        title: Text("Error: Bitte wähle einen User aus."),
                                        actions: [
                                          TextButton(
                                            child: Text("Ok"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    })
                                  },
                                  if(selectedRow.length == 1){
                                    uid = selectedRow[0]['uid'],
                                    await authproviderInstance.updateUserStatus(uid, 'aktiv'),
                                  },
                                  if(selectedRow.length >= 2) {

                                    for (var i=0; i<selectedRow.length;i++){
                                      await authproviderInstance.updateUserStatus(selectedRow[i]['uid'], 'aktiv'),
                                    },
                                  },
                                  userTable.selecteds.clear(),
                                  userTable.initializeData(),

                                },
                                icon: Icon(
                                  IconData(0xe3b0, fontFamily: 'MaterialIcons'),
                                  color: Colors.black,
                                ),
                                label: Text("Freischalten",
                                    style: TextStyle(
                                        color: Colors.black
                                    )
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.grey),
                                  padding: MaterialStateProperty.all<EdgeInsets>(
                                      EdgeInsets.all(10)),
                                ),
                              ),
                            ],
                          ),


                        ],
                      ),


                      reponseScreenSizes: [ScreenSize.xs],
                      actions: [
                        if (userTable.isSearch)
                          Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Enter search term based on ' +
                                        userTable.searchKey
                                            .replaceAll(new RegExp('[\\W_]+'), ' ')
                                            .toUpperCase(),
                                    prefixIcon: IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          setState(() {
                                            userTable.isSearch = false;
                                          });
                                          userTable.initializeData();
                                        }),
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.search), onPressed: () {})),
                                onSubmitted: (value) {
                                  userTable.filterData(value);
                                },
                              )),
                        if (!userTable.isSearch)
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  userTable.isSearch = true;
                                });
                              })
                      ],
                      headers: userTable.headers,
                      source: userTable.usersTableSource,
                      selecteds: userTable.selecteds,
                      showSelect: userTable.showSelect,
                      autoHeight: false,
                      dropContainer: (data) {
                        if (int.tryParse(data['id'].toString()).isEven) {
                          return Text("is Even");
                        }
                        return _DropDownContainer(data: data);
                      },
                      onChangedRow: (value, header) {
                        /// print(value);
                        /// print(header);
                      },
                      onSubmittedRow: (value, header) {
                        /// print(value);
                        /// print(header);
                      },
                      onTabRow: (data) {
                        print(data);
                      },
                      onSort: userTable.onSort,
                      expanded: userTable.expanded,
                      sortAscending: userTable.sortAscending,
                      sortColumn: userTable.sortColumn,
                      isLoading: userTable.isLoading,
                      onSelect: userTable.onSelected,
                      onSelectAll: userTable.onSelectAll,
                      footers: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Rows per page:"),
                        ),
                        if (userTable.perPages.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton<int>(
                              value: userTable.currentPerPage,
                              items: userTable.perPages
                                  .map((e) => DropdownMenuItem<int>(
                                child: Text("$e"),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: userTable.onChanged,
                              isExpanded: false,
                            ),
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child:
                          Text("${userTable.currentPage} - ${userTable.currentPerPage} of ${userTable.total}"),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          onPressed: userTable.previous,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: userTable.next,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ])),
    );
  }
}

class _DropDownContainer extends StatelessWidget {
  final Map<String, dynamic> data;
  const _DropDownContainer({Key key, @required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = data.entries.map<Widget>((entry) {
      Widget w = Row(
        children: [
          Text(entry.key.toString()),
          Spacer(),
          Text(entry.value.toString()),
        ],
      );
      return w;
    }).toList();

    return Container(
      /// height: 100,
      child: Column(
        /// children: [
        ///   Expanded(
        ///       child: Container(
        ///     color: Colors.red,
        ///     height: 50,
        ///   )),

        /// ],
        children: _children,
      ),
    );
  }
}