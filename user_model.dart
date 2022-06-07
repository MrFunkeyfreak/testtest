import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String UID = "uid";
  final String USERNAME = "username";
  final String EMAIL = "email";
  final String FIRSTNAME = "first name";
  final String LASTNAME = "last name";
  final String BIRTHDAY = "birthday";
  final String GENDER = "gender";
  final String STATUS = "status";

  String _uid;
  String _username;
  String _email;
  String _firstName;
  String _lastName;
  String _birthday;
  String _gender;
  String _status;

//  getters
  String get uid => _uid;
  String get username => _username;
  String get email => _email;
  String get firstName => _firstName;
  String get lastName => _lastName;
  String get birthday => _birthday;
  String get gender => _gender;
  String get stats => _status;


  UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String,dynamic>;
    _uid = data[UID];
    _username = data[USERNAME];
    _email = data[EMAIL];
    _firstName = data[FIRSTNAME];
    _lastName = data[LASTNAME];
    _birthday = data[BIRTHDAY];
    _gender = data[GENDER];
    _status = data[STATUS];
  }
}