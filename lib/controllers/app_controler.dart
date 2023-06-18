import 'dart:convert';
import 'dart:io';

import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/models/user_model.dart';
import 'package:alpha/screen/dashboard_screen.dart';
import 'package:alpha/screen/onboarding_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:google_sign_in/google_sign_in.dart';

import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppControler extends GetxController {
  Rx<TextEditingController> nomUser = TextEditingController().obs;
  Rx<TextEditingController> mailUser = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> passwordConfitm = TextEditingController().obs;
  Rx<TextEditingController> resetPasswords = TextEditingController().obs;
  final FirebaseFirestore _instancefirestore = FirebaseFirestore.instance;

  //  final FirebaseStorage firebase_storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<RoundedLoadingButtonController> buttonController =
      RoundedLoadingButtonController().obs;
  var numberDiffusion = TextEditingController().obs;
  var intervalDiffusion = TextEditingController().obs;
  var userid = "";
  var userlLogin = false.obs;
  var percentageMusic = 0.obs;
  var isPlaying = false.obs;
  var localPath = "".obs;
  late Rx<UserModel?> userData = Rx<UserModel?>(null);
  String day = "${DateTime.now().day}";
  String month = "${DateTime.now().month}";
  var base64File = "".obs;
  var urlfile = "".obs;
  var upload = false.obs;
  var typefile = "".obs;
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
      uploadFileToFirebaseStorage(typefile.value).then((value) {
        print("envoye");
        saveuser(context);
      });
    }
  }

  saveuser(context) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: mailUser.value.text,
        password: password.value.text,
      );
      var datauser = {
        "nomuser": nomUser.value.text,
        "mailuser": mailUser.value.text,
        "numero": "",
        "userid": userCredential.user!.uid,
        "avatar": urlfile.value
      };
      _instancefirestore
          .collection(AppConstants.collectionUsersFS)
          .doc(userCredential.user!.uid)
          .set(datauser);
      buttonController.value.reset();
      mailUser.value.clear();
      nomUser.value.clear();
      password.value.clear();
      passwordConfitm.value.clear();
      Get.offAll(() => const DashboardScreen());
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

// Connexion avec Google
  signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    final User? user = userCredential.user;
    final DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();

    if (userSnapshot.exists) {
      Get.offAll(() => const DashboardScreen());
    } else {
      var datauser = {
        "nomuser": user.displayName,
        "mailuser": user.email,
        "numero": user.phoneNumber,
        "userid": user.uid,
        "avatar": user.photoURL
      };

      _instancefirestore
          .collection(AppConstants.collectionUsersFS)
          .doc(userCredential.user!.uid)
          .set(datauser)
          .then((value) => Get.offAll(() => const Onboarding()));
    }
  }

  // Fonctio pour reinitialiser le mot de passe
  resetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: resetPasswords.value.text);
      messageSucces('Email de réinitialisation envoyé');
      resetPasswords.value.clear();
    } catch (e) {
      messageError('Erreur lors de l\'envoi de l\'email de réinitialisation');
    }
  }

  Future<void> signIn(context) async {
    if (mailUser.value.text.isEmpty) {
      buttonController.value.error();
      buttonController.value.reset();
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
          MaterialPageRoute(builder: (context) => const Onboarding()),
          (route) => false,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'invalid-email') {
          buttonController.value.error();

          messageError("Adresse e-mail invalide");
          buttonController.value.reset();
        } else if (e.code == 'user-disabled') {
          buttonController.value.error();
          messageError("L'utilisateur est désactivé");
          buttonController.value.reset();
        } else if (e.code == 'user-not-found') {
          buttonController.value.error();
          messageError("Utilisateur introuvable");
          buttonController.value.reset();
        } else if (e.code == 'wrong-password') {
          buttonController.value.error();
          messageError("Mot de passe incorrect");
          buttonController.value.reset();
        }
      } catch (e) {
        print(e);
      }
    }
  }

  fetUserData() async {
    QuerySnapshot q = await _instancefirestore
        .collection(AppConstants.collectionUsersFS)
        .where("uid", isEqualTo: _auth.currentUser!.uid)
        .get();
    if (q.docs.isNotEmpty) {
      final datafs = q.docs.first.data();
      userData.value = UserModel.fromJson(datafs as Map<String, dynamic>);
      // userid.value = q.docs.first.id;
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

  messageSucces(message) {
    Get.snackbar("Echec", message,
        colorText: Colors.white,
        shouldIconPulse: true,
        backgroundColor: Colors.green,
        icon: const Icon(
          IconsaxBold.check,
          color: Colors.white,
        ));
  }

  selectifile(typefiles) async {
    typefile.value = typefiles;
    FileType type = FileType.media;
    if (typefiles == "image") {
      type = FileType.image;
    }
    if (typefiles == "audio") {
      type = FileType.audio;
    }
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: type);

    if (result != null) {
      File file = File(result.files.single.path!);
      localPath.value = result.files.single.path!;
      base64File.value = base64Encode(file.readAsBytesSync());
    }
    print(typefile.value);
  }

  Future<void> uploadFileToFirebaseStorage(typemedia) async {
    String childstrorage = "";
    String contentype = "";
    if (typemedia == "image") {
      childstrorage = "image_files";
      contentype = "image/jpg";
    }
    if ((typemedia == "audio")) {
      childstrorage = "audio_files";
      contentype = "audio/jpg";
    }
    upload.value = true;
    Uint8List audioBytes = base64Decode(base64File.value);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('$childstrorage/${DateTime.now().millisecondsSinceEpoch}');

    firebase_storage.UploadTask uploadTask = storageRef.putData(
      audioBytes,
      firebase_storage.SettableMetadata(contentType: contentype),
    );

    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    urlfile.value = downloadUrl;
  }

  Future<void> initializeSharedPreferences() async {}

  addsetting() async {
    SharedPreferences prefs;

    try {
      prefs = await SharedPreferences.getInstance();
    } on PlatformException catch (e) {
      print(
          "Erreur lors de l'initialisation de SharedPreferences: ${e.message}");
      return; // Quitter la fonction en cas d'erreur
    }

    var intervalSecond = int.parse(intervalDiffusion.value.text) * 60;
    var setting = {
      "urlfile": urlfile.value,
      "numberDiffusion": numberDiffusion.value.text,
      "interval": intervalDiffusion.value.text,
      "intervalSecondd": intervalSecond,
      "userid": _auth.currentUser!.uid
    };

    prefs.setInt("numberDiffusion", int.parse(numberDiffusion.value.text));
    prefs.setInt("interval", int.parse(intervalDiffusion.value.text));
    prefs.setInt("urlfile", int.parse(urlfile.value));
    prefs.setInt("intervalSecondd", intervalSecond);

    QuerySnapshot q = await _instancefirestore
        .collection(AppConstants.collectionDiffusionFS)
        .where('iduser', isEqualTo: _auth.currentUser!.uid)
        .get();

    if (q.docs.isEmpty) {
      _instancefirestore
          .collection(AppConstants.collectionSettingFS)
          .add(setting);
    } else {
      _instancefirestore
          .collection(AppConstants.collectionSettingFS)
          .doc(q.docs.first.id)
          .update(setting);
    }

    numberDiffusion.value.clear();
    intervalDiffusion.value.clear();
    urlfile.value = "";
    upload.value = false;
  }

  createDiffusion() async {
    QuerySnapshot q = await _instancefirestore
        .collection(AppConstants.collectionDiffusionFS)
        .where('iduser', isEqualTo: _auth.currentUser!.uid)
        .where("date",
            isNotEqualTo: "${DateTime.now().day}/${DateTime.now().month}")
        .get();
    if (q.docs.length != 1) {
      var datadif = {
        "date": "${DateTime.now().day}/${DateTime.now().month}",
        "dateComplete": DateTime.now(),
        "iduser": _auth.currentUser!.uid,
      };
      _instancefirestore
          .collection(AppConstants.collectionDiffusionFS)
          .add(datadif);
    } else {
      // redirection dashboard
    }
  }

  updateDiffusion(numberDiffusion, idDiffusion) async {
    QuerySnapshot q = await _instancefirestore
        .collection(AppConstants.collectionDiffusionFS)
        .where('iduser', isEqualTo: _auth.currentUser!.uid)
        .where("date",
            isNotEqualTo: "${DateTime.now().day}/${DateTime.now().month}")
        .get();
    if (q.docs.length != 1) {
      _instancefirestore
          .collection(AppConstants.collectionDiffusionFS)
          .doc(idDiffusion)
          .update({"diffusion.0": ""});
    } else {
      // redirection dashboard
    }
  }
}
