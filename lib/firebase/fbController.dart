import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/userModel.dart';

class FbControllerAddUser {

    CollectionReference users = FirebaseFirestore.instance.collection('users');

    Future<void> addUser({required userModel user}) {
      // Call the user's CollectionReference to add a new user

      return users
          .add(user.toJson())
          .then((value) => print("User Added"))
          .catchError((error) => print("Failed to add user: $error"));
    }

    Stream<QuerySnapshot> getData() async* {
      yield* users.snapshots();
    }

    Future<void> deleteUser(String id) async{
    await  users.doc(id).delete();
    }

  }
