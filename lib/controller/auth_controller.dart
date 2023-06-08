import 'dart:html';

import 'package:app_contact/model/usermdl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');

  bool get success => false;

  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async{
    try{
      final UserCredential userCredential = await auth .signInWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user; 

      if (user != null){
        final DocumentSnapshot snapshot = await usersCollection.doc(user.uid).get();

        final UserModel currentUser = UserModel(
          uId: user.uid,
          email: user.email ?? '',
          name: snapshot['name'] ?? '',
        );

        return currentUser;
      }
    } catch(e){
      print('Error');
    }
    return null;
  }

  Future<UserModel?> registerwithEmailandPassword(
      String email, String password, String name) async {
    try {
      final UserCredential userCredential = await auth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = userCredential.user;

      if (user!=null) {
        final UserModel newUser = UserModel(name: name, email: email ?? '', uId: user.uid);

        await usersCollection.doc(newUser.uId).set(newUser.toMap());

        return newUser;
      }
    } catch (e) {
      print('Error registering user : $e');
    }
  }

  // Future<UserModel?> registerWithEmailAndPassword(String email, String password, String name) async{
  //   try{
  //     final UserCredential usersCredential = await auth .createUserWithEmailAndPassword(email: email, password: password);
  //     final User? user = usersCredential.user; 

  //     if (user != null){

  //       final UserModel newUser = UserModel(
          // uId: user.uid,
          // email: user.email ?? '',
          // name: name,

  //         await usersCollection.doc(newUser.uId).set(newUser.toMap());
  //       );

  //       return newtUser;
  //     }
  //   }catch{
  //     print('Error');
  //   }
  //   return null;
  // }
}
