import 'package:cloud_firestore/cloud_firestore.dart';
import '../datamodels/user_model.dart';

class UserServices {
  String adminsCollection = "admins";
  String usersCollection = "users";

  void createAdmin({
    String uid,
    String username,
    String email,
    String firstName,
    String lastName,
    String birthday,
    String gender,
    String status,

  }) {
    FirebaseFirestore.instance.collection(adminsCollection).doc(uid).set({
      'uid': uid,
      'username': username,
      'email': email,
      'first name': firstName,
      'last name': lastName,
      'birthday': birthday,
      'gender': gender,
      'status': status,
    });
  }

  void updateUserData(Map<String, dynamic> values) {  //update the values from the person, who has the specific id
    FirebaseFirestore.instance
        .collection(adminsCollection)
        .doc(values['id'])
        .update(values);
  }

  Future<UserModel> getAdminById(String id) =>  //get the current admin logged in
      FirebaseFirestore.instance.collection(adminsCollection).doc(id).get().then((doc) {
        return UserModel.fromSnapshot(doc);
      });

  Future<List<UserModel>> getAllUsers() async =>
      FirebaseFirestore.instance.collection(adminsCollection).get().then((result) {
        List<UserModel> users = [];
        for (DocumentSnapshot user in result.docs) {
          users.add(UserModel.fromSnapshot(user));
        }
        return users;
      });
}