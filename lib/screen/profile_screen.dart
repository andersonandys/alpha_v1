import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
    required this.nom,
    required this.email,
    required this.number,
  }) : super(key: key);

  String nom;
  String email;
  String number;
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final appControler = Get.put(AppControler());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Finalisation',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Completez votre profil et faites des a present des economies",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              _titltText("Votre nom"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                controller: appControler.nomUser.value,
                hintText: widget.nom,
              ),
              const SizedBox(height: 20),
              _titltText("Adresse e-mail"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                hintText: widget.email,
                controller: appControler.mailUser.value,
              ),
              const SizedBox(height: 20),
              _titltText("Numero de telephone"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                hintText: widget.number,
                controller: appControler.numberuser.value,
              ),
              const SizedBox(height: 20),
              _titltText("Mot de passe"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                hintText: "*********",
                controller: appControler.password.value,
              ),
              const Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  appControler.updateUser();
                },
                child: const Text(
                  "Mettre a jour",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titltText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
