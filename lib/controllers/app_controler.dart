import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/screen/dashboard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';

class AppControler extends GetxController {
  Rx<TextEditingController> nomUser = TextEditingController().obs;
  Rx<TextEditingController> mailUser = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> passwordConfitm = TextEditingController().obs;
  final FirebaseFirestore _instancefirestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<RoundedLoadingButtonController> buttonController =
      RoundedLoadingButtonController().obs;
  var userlLogin = false.obs;
  var percentageMusic = 0.obs;
  var isPlaying = false.obs;
  checkAuth() {
    if (_auth.currentUser != null) {
      userlLogin.value = true;
    } else {
      userlLogin.value = false;
    }
  }

  creatcompte(context) {
    if (nomUser.value.text.isEmpty) {
      messageError("Nous vous prions de saisir votre nom");
      buttonController.value.reset();
    } else if (mailUser.value.text.isEmpty) {
      messageError("Nous vous prions de saisir votre adresse mail");
      buttonController.value.reset();
    } else if (password.value.text.isEmpty) {
      messageError("Nous vous prions de saisir un mot de passe");
      buttonController.value.reset();
    } else if (passwordConfitm.value.text.isEmpty) {
      messageError("Nous vous prions de confirmer le mot de passe");
      buttonController.value.reset();
    } else if (password.value.text != passwordConfitm.value.text) {
      messageError("Vos mots de passent ne correspodent pas");
      buttonController.value.reset();
    } else {
      saveuser(context);
    }
  }

  saveuser(context) async {
    var datauser = {
      "nomuser": nomUser.value.text,
      "mailuser": mailUser.value.text,
      "numero": ""
    };
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: mailUser.value.text,
        password: password.value.text,
      );
      _instancefirestore
          .collection(AppConstants.collectionUsersFS)
          .doc(userCredential.user!.uid)
          .set(datauser);
      buttonController.value.reset();
      mailUser.value.clear();
      nomUser.value.clear();
      password.value.clear();
      passwordConfitm.value.clear();
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const DashboardScreen()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        messageError("Adresse e-mail invalide");
        buttonController.value.reset();
      } else if (e.code == 'weak-password') {
        messageError(
            "Mot de passe trop court. Votre mot de passe doit contenir 6 caracteres");
        buttonController.value.reset();
      } else if (e.code == 'email-already-in-use') {
        messageError(
            "L adresse e-mail existe déjà, nous vous prions de vous connecter");
        buttonController.value.reset();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> signIn(context) async {
    if (mailUser.value.text.isEmpty) {
      buttonController.value.error();
      messageError("Nous vous prions de saisir votre adresse mail");
      buttonController.value.reset();
    } else if (password.value.text.isEmpty) {
      buttonController.value.error();
      messageError("Nous vous prions de saisir votre adresse mot de pass");
      buttonController.value.reset();
    } else {
      try {
        final UserCredential userCredential =
            await _auth.signInWithEmailAndPassword(
          email: mailUser.value.text,
          password: password.value.text,
        );
        mailUser.value.clear();
        password.value.clear();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          buttonController.value.error();
          messageError("Adresse e-mail invalide");
        } else if (e.code == 'user-disabled') {
          messageError("L'utilisateur est désactivé");
        } else if (e.code == 'user-not-found') {
          messageError("Utilisateur introuvable");
        } else if (e.code == 'wrong-password') {
          messageError("Mot de passe incorrect");
        }
      } catch (e) {
        print(e);
      }
    }
  }

  messageError(message) {
    Get.snackbar("Echec", message,
        colorText: Colors.white,
        shouldIconPulse: true,
        backgroundColor: Colors.red,
        icon: const Icon(
          IconsaxBold.check,
          color: Colors.white,
        ));
  }
}
