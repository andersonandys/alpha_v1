import 'package:alpha/screen/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
                hintText: "David Axel",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Veuillez entrer votre nom";
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              const SizedBox(height: 20),
              _titltText("Adresse e-mail"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                hintText: "daniel@kameni.me",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Veuillez entrer votre nom";
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              const SizedBox(height: 20),
              _titltText("Numero de telephone"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                hintText: "+1 234 567 890",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Veuillez entrer votre nom";
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              const SizedBox(height: 20),
              _titltText("Mot de passe"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                hintText: "*********",
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Veuillez entrer votre nom";
                  }
                  return null;
                },
                onSaved: (value) {},
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
                onPressed: () {},
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
