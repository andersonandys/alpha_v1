import 'dart:convert';
import 'dart:io';

import 'package:alpha/constants/app_constants.dart';
import 'package:alpha/models/user_model.dart';
import 'package:alpha/screen/dashboard_screen.dart';
import 'package:alpha/screen/diffusion_screen.dart';
import 'package:alpha/screen/onboarding_screen.dart';
import 'package:alpha/screen/succesdiffusion_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
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
  Rx<TextEditingController> numberuser = TextEditingController().obs;
  Rx<TextEditingController> nomfeed = TextEditingController().obs;
  Rx<TextEditingController> mailfeed = TextEditingController().obs;
  Rx<TextEditingController> messagefeed = TextEditingController().obs;
  Rx<TextEditingController> faqtitre = TextEditingController().obs;
  Rx<TextEditingController> faqcontenu = TextEditingController().obs;
  final FirebaseFirestore _instancefirestore = FirebaseFirestore.instance;

  var card1 = "".obs;
  var card2 = "".obs;
  var card3 = "".obs;
  var paragraphe1 = "".obs;
  var lancement = "".obs;
  var historique = "".obs;
  var feedback = "".obs;
  var faq = "".obs;
  var namuserInfo = "".obs;
  var mailuserInfo = "".obs;
  var audioPlayer = AudioPlayer().obs;
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
  var loaded = false.obs;
  var upload = false.obs;
  var typefile = "".obs;
  var isload = false.obs;
  var idDiffusion = "".obs;
  var idChild = [].obs;
  var currentMusicIndex = 1.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getlangue();
  }

  checkAuth() {
    if (_auth.currentUser != null) {
      userlLogin.value = true;
    } else {
      userlLogin.value = false;
    }
  }

  getuserData() {
    _instancefirestore
        .collection(AppConstants.collectionUsersFS)
        .where("userid", isEqualTo: _auth.currentUser!.uid)
        .get()
        .then((value) {
      for (var element in value.docs) {
        namuserInfo.value = element["nomuser"];
        mailuserInfo.value = element["mailuser"];
      }
    });
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
      if (typefile.isNotEmpty) {
        uploadFileToFirebaseStorage(typefile.value).then((value) {});
      } else {
        saveuser(context);
      }
    }
  }

  saveuser(context) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: mailUser.value.text,
        password: password.value.text,
      );
      _auth.currentUser!.sendEmailVerification();
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
      Get.offAll(() => const Onboarding());
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
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
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

  changeavatar() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      File file = File(result.files.single.path!);
      localPath.value = result.files.single.path!;
      base64File.value = base64Encode(file.readAsBytesSync());
      isload.value = true;
    }
    uploadFileToFirebaseStorage("image");
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
    if (isload.isTrue) {
      _instancefirestore
          .collection(AppConstants.collectionUsersFS)
          .doc(_auth.currentUser!.uid)
          .update({"avatar": downloadUrl}).then(
              (value) => isload.value = false);
    }
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

  updateDiffusion() async {
    print(currentMusicIndex.value);
    print(idDiffusion.value);
    if (idDiffusion.isNotEmpty) {
      if (idChild.length < currentMusicIndex.value) {
        _instancefirestore
            .collection(AppConstants.collectionDiffusionFS)
            .doc(idDiffusion.value)
            .update({"finish": true});
        audioPlayer.value.stop();
        Get.offAll(() => const SuccesdiffusionScreen());
      } else {
        int indexToUpdate =
            currentMusicIndex.value - 1; // Ajustement de l'indice
        _instancefirestore
            .collection(AppConstants.collectionDiffusionFS)
            .doc(idDiffusion.value)
            .collection("child")
            .doc(idChild[indexToUpdate])
            .update({"statut": "Succēs"}).then((value) {
          print("modifier avec success");
        });
        currentMusicIndex.value++;
      }
    } else {
      print("plus de diffudion");
    }
  }

  updateUser() async {
    print("object");
    if (nomUser.value.text.isNotEmpty) {
      _instancefirestore
          .collection(AppConstants.collectionUsersFS)
          .doc(_auth.currentUser!.uid)
          .update({"nomuser": nomUser.value.text}).then(
              (value) => nomUser.value.clear());
    } else {
      print("vide");
    }
    if (mailUser.value.text.isNotEmpty) {
      _instancefirestore
          .collection(AppConstants.collectionUsersFS)
          .doc(_auth.currentUser!.uid)
          .update({"mailuser": mailUser.value.text}).then(
              (value) => mailUser.value.clear());
    }
    if (numberuser.value.text.isNotEmpty) {
      _instancefirestore
          .collection(AppConstants.collectionUsersFS)
          .doc(_auth.currentUser!.uid)
          .update({"numero": numberuser.value.text}).then(
              (value) => numberuser.value.clear());
    }
    if (password.value.text.isNotEmpty) {
      try {
        User? user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          await user.updatePassword(password.value.text);
        }
      } catch (e) {
        messageError('Erreur lors de la mise à jour du mot de passe');
      }
    }
    if (nomUser.value.text.isNotEmpty ||
        mailUser.value.text.isNotEmpty ||
        numberuser.value.text.isNotEmpty ||
        password.value.text.isNotEmpty) {
      messageSucces("Mise a jour effectue avec succes");
    }
  }

  diffusionverif(context) async {
    loaded.value = true;
    QuerySnapshot q = await _instancefirestore
        .collection(AppConstants.collectionDiffusionFS)
        .where('iduser', isEqualTo: _auth.currentUser!.uid)
        .where("date",
            isEqualTo: "${DateTime.now().day}/${DateTime.now().month}")
        .get();
    if (q.docs.length == 1) {
      print(q.docs.first.id);
      if (q.docs.first["finish"] == true) {
        loaded.value = false;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => SuccesdiffusionScreen(),
            ));
      } else {
        // redirection vers le dashboard
        idDiffusion.value = q.docs.first.id;
        loaded.value = false;
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => DiffusionScreen(
                idDiffusion: q.docs.first.id,
                finish: q.docs.first["finish"],
              ),
            ));
      }
    } else {
      //  creation des differents diffusions
      var dataDiffusion = {
        "iduser": _auth.currentUser!.uid,
        "nbreDiffusion": 4,
        "date": "${DateTime.now().day}/${DateTime.now().month}",
        "dateComplet":
            "${DateTime.now().day} ${DateTime.now().month} ${DateTime.now().year}",
        "range": DateTime.now().millisecondsSinceEpoch,
        "finish": false
      };
      _instancefirestore
          .collection(AppConstants.collectionDiffusionFS)
          .add(dataDiffusion)
          .then((value) {
        idDiffusion.value = value.id;
        for (var i = 1; i < 5; i++) {
          var dataChildDiffusion = {
            "urlaudio": "",
            "statut": "A venir",
            "idDiffusion": value.id,
            "range": DateTime.now().millisecondsSinceEpoch,
            "niveau": i
          };
          _instancefirestore
              .collection(AppConstants.collectionDiffusionFS)
              .doc(value.id)
              .collection("child")
              .add(dataChildDiffusion);
          if (i == 4) {
            loaded.value = false;
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      DiffusionScreen(idDiffusion: value.id, finish: false),
                ));
          }
        }
      });
    }
  }

  sendFeedback(context) {
    if (nomfeed.value.text.isEmpty) {
      messageError("Nous vous prions de saisir votre nom");
      buttonController.value.reset();
    } else if (mailfeed.value.text.isEmpty) {
      messageError("Nous vous prions de saisir votre adresse e-mail");
      buttonController.value.reset();
    } else if (messagefeed.value.text.isEmpty) {
      messageError("Nous vous prions de saisir un message");
      buttonController.value.reset();
    } else {
      var datafeed = {
        "nom": nomfeed.value.text,
        "email": mailfeed.value.text,
        "message": messagefeed.value.text,
        "iduser": _auth.currentUser!.uid,
        "date": DateTime.now()
      };
      _instancefirestore
          .collection(AppConstants.collectionfeedbackFS)
          .add(datafeed);
    }
    messageSucces("votre avis a été pris envoye");
    buttonController.value.reset();
  }

  addfaq() {
    if (faqtitre.value.text.isEmpty) {
      messageError("Saisissez un titre");
      buttonController.value.reset();
    } else if (faqcontenu.value.text.isEmpty) {
      messageError("Saisissez un contenu");
      buttonController.value.reset();
    } else {
      var data = {
        "titre": faqtitre.value.text,
        "contenu": faqcontenu.value.text,
        "range": DateTime.now().millisecondsSinceEpoch
      };
      _instancefirestore.collection(AppConstants.collectionfaqFS).add(data);
      messageSucces("Faq ajoute avec sucess");
      faqcontenu.value.clear();
      faqtitre.value.clear();
      buttonController.value.reset();
    }
  }

  deletefaq(idelete) {
    _instancefirestore
        .collection(AppConstants.collectionfaqFS)
        .doc(idelete)
        .delete();
    messageSucces("Element retire du FAQ");
  }

  void getlangue() {
    _instancefirestore
        .collection(AppConstants.collectionexpressionFS)
        .snapshots()
        .listen((querySnapshot) {
      for (var element in querySnapshot.docs) {
        card1.value = element["card1"];
        card2.value = element["card2"];
        card3.value = element["card3"];
        paragraphe1.value = element["paragraphe1"];
        lancement.value = element["lancement"];
        historique.value = element["historique"];
        feedback.value = element["feedback"];
        faq.value = element["faq"];
      }
    });
  }

  void createNotification(message) {
    // Configuration de la notification
    var content = NotificationContent(
      id: 0,
      channelKey: 'basic_channel',
      title: 'Notification pour la diffusion',
      body: message,
      notificationLayout: NotificationLayout.Default,
    );

    // Affichage de la notification
    AwesomeNotifications().createNotification(content: content);
  }
}
