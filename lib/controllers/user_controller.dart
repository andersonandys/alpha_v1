import 'package:alpha/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../screen/home_noconnect_screen.dart';

class UserController extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  late UserModel _userData;

  String? refUserDoc;

  Future<void> checkAuth(BuildContext context,
      {void Function()? verified, bool initData = false}) async {
    final User? user = _auth.currentUser;

    if (user != null) {
      if (initData) await populateUserData(user);
      if (verified != null) return verified();
    } else {
      return await redirNoVerified(context);
    }
  }

  Future<void> redirNoVerified(BuildContext context) async =>
      await Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeNoconnectScreen()),
          (route) => false);

  Future<void> initRegisterUserData(User? userData) async {
    if (userData != null) {
      _userData = UserModel(uid: userData.uid, email: userData.email);

      await _db.collection(AppConstants.collectionUsersFS).add(_userData.toJson());
    }
  }

  Future<void> populateUserData(User? userData) async {
    if (userData != null) {
      QuerySnapshot q = await _db
          .collection(AppConstants.collectionUsersFS)
          .where('uid', isEqualTo: userData.uid)
          .get();
      if (q.docs.length == 1) {
        final fsdata = q.docs.first.data();
        _userData = UserModel.fromJson(fsdata as Map<String, dynamic>);

        refUserDoc = q.docs.first.id;
      } else {
        throw "Erreur";
      }
    }
  }
}
