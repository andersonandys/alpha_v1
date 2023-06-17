import 'dart:convert';
import 'dart:io';

import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/models/user_model.dart';
import 'package:alpha/screen/dashboard_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppControler extends GetxController {
  Rx<TextEditingController> nomUser = TextEditingController().obs;
  Rx<TextEditingController> mailUser = TextEditingController().obs;
  Rx<TextEditingController> password = TextEditingController().obs;
  Rx<TextEditingController> passwordConfitm = TextEditingController().obs;
  final FirebaseFirestore _instancefirestore = FirebaseFirestore.instance;

  //  final FirebaseStorage firebase_storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rx<RoundedLoadingButtonController> buttonController =
      RoundedLoadingButtonController().obs;
  var numberDiffusion = TextEditingController().obs;
  var intervalDiffusion = TextEditingController().obs;
  var userid = FirebaseAuth.instance.currentUser!.uid.obs;
  var userlLogin = false.obs;
  var percentageMusic = 0.obs;
  var isPlaying = false.obs;
  Rx<Stream<QuerySnapshot<Map<String, dynamic>>>> DiffusionData =
      FirebaseFirestore.instance
          .collection("diffusions")
          .where("iduser", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where("date",
              isEqualTo: "${DateTime.now().day}/${DateTime.now().month}")
          .snapshots()
          .obs;
  late Rx<UserModel?> userData = Rx<UserModel?>(null);
  String day = "${DateTime.now().day}";
  String month = "${DateTime.now().month}";
  final datadDifusion = FirebaseFirestore.instance
      .collection(AppConstants.collectionDiffusionFS)
      .where("date", isEqualTo: "${DateTime.now().day}/${DateTime.now().month}")
      .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .obs;
  var urlaudio = "".obs;
  var upload = false.obs;
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

  fetUserData() async {
    QuerySnapshot q = await _instancefirestore
        .collection(AppConstants.collectionUsersFS)
        .where("uid", isEqualTo: _auth.currentUser!.uid)
        .get();
    if (q.docs.isNotEmpty) {
      final datafs = q.docs.first.data();
      userData.value = UserModel.fromJson(datafs as Map<String, dynamic>);
      userid.value = q.docs.first.id;
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

  selectaudio() async {
    ("object");
    // Action pour le bouton d'inscription
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.audio);

    if (result != null) {
      File file = File(result.files.single.path!);
      String base64Audio = base64Encode(file.readAsBytesSync());
      uploadFileToFirebaseStorage(base64Audio);
    } else {
      // User canceled the picker
    }
  }

  Future<void> uploadFileToFirebaseStorage(String base64Audio) async {
    upload.value = true;
    Uint8List audioBytes = base64Decode(base64Audio);
    firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('audio_files/${DateTime.now().millisecondsSinceEpoch}');

    firebase_storage.UploadTask uploadTask = storageRef.putData(
      audioBytes,
      firebase_storage.SettableMetadata(contentType: 'audio/mp3'),
    );

    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => null);
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    urlaudio.value = downloadUrl;
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
      "urlaudio": urlaudio.value,
      "numberDiffusion": numberDiffusion.value.text,
      "interval": intervalDiffusion.value.text,
      "intervalSecondd": intervalSecond,
      "userid": _auth.currentUser!.uid
    };

    prefs.setInt("numberDiffusion", int.parse(numberDiffusion.value.text));
    prefs.setInt("interval", int.parse(intervalDiffusion.value.text));
    prefs.setInt("urlaudio", int.parse(urlaudio.value));
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
    urlaudio.value = "";
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
}
