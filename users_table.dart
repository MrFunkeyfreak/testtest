import 'dart:math';
import 'package:flutter/material.dart';
import 'package:responsive_table/responsive_table.dart';

import '../../datamodels/user_model.dart';
import '../../services/user_services.dart';

class UsersTable with ChangeNotifier {

  List<int> perPages = [10, 20, 50, 100];
  int total = 100;
  int currentPerPage = 10;
  List<bool> expanded;
  String searchKey = "id";

  int currentPage = 1;
  bool isSearch = false;
  List<Map<String, dynamic>> sourceOriginal = [];
  List<Map<String, dynamic>> sourceFiltered = [];
  List<Map<String, dynamic>> usersTableSource = [];
  List<Map<String, dynamic>> selecteds = [];
  // ignore: unused_field
  String selectableKey = "id";

  String sortColumn;
  bool sortAscending = true;
  bool isLoading = true;
  bool showSelect = true;
  var random = new Random();

  List<DatatableHeader> headers = [
    DatatableHeader(
        text: "UID",
        value: "uid",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Benutzername",
        value: "username",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "E-Mail",
        value: "email",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Vorname",
        value: "first name",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Nachname",
        value: "last name",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Geburtsdatum",
        value: "birthday",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
    DatatableHeader(
        text: "Geschlecht",
        value: "gender",
        show: true,
        sortable: true,
        textAlign: TextAlign.left),
  ];

  UserServices _userServices = UserServices();
  List<UserModel> _users = <UserModel>[];
  List<UserModel> get users => _users;

  Future _loadFromFirebase() async {
    _users = await _userServices.getAllUsers();
  }

  List<Map<String, dynamic>> _getUsersData() {
    List<Map<String, dynamic>> temps = [];
    var i = _users.length;
    print("Users:" + i.toString());
    // ignore: unused_local_variable
    for (UserModel userData in _users) {
      temps.add({
        "uid": userData.uid,
        "username": userData.username ,
        "email": userData.email ,
        "first name": userData.firstName ,
        "last name": userData.lastName ,
        "birthday": userData.birthday ,
        "gender": userData.gender ,
      });
      i++;
    }
    return temps;
  }

  initializeData() async {
    mockPullData();
  }

  mockPullData() async {
    expanded = List.generate(currentPerPage, (index) => false);

    isLoading = true;
    notifyListeners();
    await _loadFromFirebase();
    sourceOriginal.clear();
    sourceOriginal.addAll(_getUsersData());
    sourceFiltered = sourceOriginal;
    total = sourceFiltered.length;
    usersTableSource = sourceFiltered.getRange(0, _users.length).toList();     //hier fehler
    isLoading = false;
    notifyListeners();
  }

  resetData({start: 0}) async {
    isLoading = true;
    notifyListeners();
    var _expandedLen =
    total - start < currentPerPage ? total - start : currentPerPage;
    expanded = List.generate(_expandedLen as int, (index) => false);
    usersTableSource.clear();
    usersTableSource = sourceFiltered.getRange(start, start + _expandedLen).toList();
    isLoading = false;
    notifyListeners();
    //hier future weggemacht
  }

  filterData(value) {
    isLoading = true;
    notifyListeners();

    try {
      if (value == "" || value == null) {
        sourceFiltered = sourceOriginal;
      } else {
        sourceFiltered = sourceOriginal
            .where((data) => data[searchKey]
            .toString()
            .toLowerCase()
            .contains(value.toString().toLowerCase()))
            .toList();
      }

      total = sourceFiltered.length;
      var _rangeTop = total < currentPerPage ? total : currentPerPage;
      expanded = List.generate(_rangeTop, (index) => false);
      usersTableSource = sourceFiltered.getRange(0, _rangeTop).toList();
    } catch (e) {
      print(e);
    }

    isLoading = false;
    notifyListeners();
  }

  onSort(dynamic value){
    isLoading = true;
    notifyListeners();
    sortColumn = value;
    sortAscending = !sortAscending;
    if (sortAscending) {
      sourceFiltered.sort((a, b) =>
          b["$sortColumn"].compareTo(a["$sortColumn"]));
    } else {
      sourceFiltered.sort((a, b) =>
          a["$sortColumn"].compareTo(b["$sortColumn"]));
    }
    var _rangeTop = currentPerPage < sourceFiltered.length
        ? currentPerPage
        : sourceFiltered.length;
    usersTableSource = sourceFiltered.getRange(0, _rangeTop).toList();
    searchKey = value;

    isLoading = false;
    notifyListeners();
  }

  onSelected(bool value, Map <String, dynamic> item){
    print("$value  $item ");
    if (value) {
      selecteds.add(item);     //Liste von Map <String, dynamic>
    } else {
      selecteds.removeAt(selecteds.indexOf(item));
    }
    notifyListeners();
  }

  onSelectAll(bool value){
    if (value) {
      selecteds = usersTableSource.map((entry) => entry).toList().cast();
    } else {
      selecteds.clear();
    }
    notifyListeners();
  }

  onChanged(int value){
    currentPerPage = value;
    currentPage = 1;
    resetData();
    notifyListeners();
  }

  previous(){
    currentPage == 1
        ? null
        : () {
      var nextSet = currentPage - currentPerPage;
      currentPage = nextSet > 1 ? nextSet : 1;
      resetData(start: currentPage - 1);
    };
    notifyListeners();
  }

  next(){
    currentPage + currentPerPage - 1 > total
        ? null
        : () {
      var nextSet = currentPage + currentPerPage;

      currentPage = nextSet < total
          ? nextSet
          : total - currentPerPage;
      resetData(start: nextSet - 1);
    };
    notifyListeners();
  }

  UsersTable.init() {
    initializeData();
  }


}