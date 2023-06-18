import 'dart:convert';
import 'dart:io';

import 'package:alpha/screen/widgets/text_form_field_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/app_controler.dart';

class SettingDiffusionScreen extends StatefulWidget {
  const SettingDiffusionScreen({Key? key}) : super(key: key);

  @override
  _SettingDiffusionScreenState createState() => _SettingDiffusionScreenState();
}

class _SettingDiffusionScreenState extends State<SettingDiffusionScreen> {
  final appController = Get.put(AppControler());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diffusion',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() => Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  "Enregistrez  vos préférences pour votre diffusion quotidienne",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 50),
                _titltText("Nombre de diffusion"),
                const SizedBox(height: 10),
                TextField(
                  controller: appController.numberDiffusion.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "0",
                    prefixIcon: Icon(Icons.numbers),
                    // suffix: suffixIcon,
                    labelStyle: TextStyle(color: Colors.black),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _titltText("Intervale de diffusion"),
                const SizedBox(height: 10),
                TextField(
                  controller: appController.intervalDiffusion.value,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: "30",
                    prefixIcon: Icon(Icons.numbers),
                    // suffix: suffixIcon,
                    labelStyle: TextStyle(color: Colors.black),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(7)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    appController.selectifile("audio");
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green, // Texte en blanc
                    minimumSize:
                        const Size(double.infinity, 60), // Hauteur du bouton
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rayon de 10
                    ),
                  ),
                  child: const Text(
                    "Ajouter de la music",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(height: 20),
                if (appController.upload.isTrue)
                  const Text(
                    'Importation de la music...',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                if (appController.urlfile.isNotEmpty)
                  const Text(
                    'Audio importe avec succes',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
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
                    appController.addsetting();
                  },
                  child: const Text(
                    "Ajouter",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          )),
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
