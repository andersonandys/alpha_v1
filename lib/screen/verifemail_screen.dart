import 'package:alpha/controllers/app_controler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerifemailScreen extends StatefulWidget {
  const VerifemailScreen({Key? key}) : super(key: key);

  @override
  _VerifemailScreenState createState() => _VerifemailScreenState();
}

class _VerifemailScreenState extends State<VerifemailScreen> {
  final appcontroller = Get.put(AppControler());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Vérification de votre mail"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Image.asset("assets/verifi.png"),
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Cher utilisateur, \n Veuillez vérifier votre compte en cliquant sur le lien de vérification que nous vous avons envoyé par e-mail.",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              textAlign: TextAlign.justify,
            )
          ],
        ),
      ),
    );
  }
}
