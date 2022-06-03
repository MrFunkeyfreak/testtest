import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_table/responsive_table.dart';
import 'package:bestfitnesstrackereu/pages/user_administration/test_table.dart';

class DataPage extends StatefulWidget {
  DataPage({Key key}) : super(key: key);
  @override
  _DataPageState createState() => _DataPageState();
}

class _DataPageState extends State<DataPage> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TestTable testTable = Provider.of<TestTable>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("RESPONSIVE DATA TABLE"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.home),
              title: Text("home"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.storage),
              title: Text("data"),
              onTap: () {},
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
                      title: TextButton.icon(
                        onPressed: () => {},
                        icon: Icon(Icons.add),
                        label: Text("new item"),
                      ),
                      reponseScreenSizes: [ScreenSize.xs],
                      actions: [
                        if (testTable.isSearch)
                          Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                    hintText: 'Enter search term based on ' +
                                        testTable.searchKey
                                            .replaceAll(new RegExp('[\\W_]+'), ' ')
                                            .toUpperCase(),
                                    prefixIcon: IconButton(
                                        icon: Icon(Icons.cancel),
                                        onPressed: () {
                                          setState(() {
                                            testTable.isSearch = false;
                                          });
                                          testTable.initializeData();
                                        }),
                                    suffixIcon: IconButton(
                                        icon: Icon(Icons.search), onPressed: () {})),
                                onSubmitted: (value) {
                                  testTable.filterData(value);
                                },
                              )),
                        if (!testTable.isSearch)
                          IconButton(
                              icon: Icon(Icons.search),
                              onPressed: () {
                                setState(() {
                                  testTable.isSearch = true;
                                });
                              })
                      ],
                      headers: testTable.headers,
                      source: testTable.usersTableSource,
                      selecteds: testTable.selecteds,
                      showSelect: testTable.showSelect,
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
                      onSort: testTable.onSort,
                      expanded: testTable.expanded,
                      sortAscending: testTable.sortAscending,
                      sortColumn: testTable.sortColumn,
                      isLoading: testTable.isLoading,
                      onSelect: testTable.onSelected,
                      onSelectAll: testTable.onSelectAll,
                      footers: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Rows per page:"),
                        ),
                        if (testTable.perPages.isNotEmpty)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            child: DropdownButton<int>(
                              value: testTable.currentPerPage,
                              items: testTable.perPages
                                  .map((e) => DropdownMenuItem<int>(
                                child: Text("$e"),
                                value: e,
                              ))
                                  .toList(),
                              onChanged: testTable.onChanged,
                              isExpanded: false,
                            ),
                          ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child:
                          Text("$testTable.currentPage - $testTable.currentPerPage of $testTable.total"),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 16,
                          ),
                          onPressed: testTable.previous,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        ),
                        IconButton(
                          icon: Icon(Icons.arrow_forward_ios, size: 16),
                          onPressed: testTable.next,
                          padding: EdgeInsets.symmetric(horizontal: 15),
                        )
                      ],
                    ),
                  ),
                ),
              ])),
      floatingActionButton: FloatingActionButton(
        onPressed: testTable.initializeData,
        child: Icon(Icons.refresh_sharp),
      ),
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