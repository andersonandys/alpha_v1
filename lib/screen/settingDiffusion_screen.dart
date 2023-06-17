import 'package:alpha/screen/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';

class SettingDiffusionScreen extends StatefulWidget {
  const SettingDiffusionScreen({Key? key}) : super(key: key);

  @override
  _SettingDiffusionScreenState createState() => _SettingDiffusionScreenState();
}

class _SettingDiffusionScreenState extends State<SettingDiffusionScreen> {
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
      body: Padding(
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
            const SizedBox(height: 20),
            _titltText("Nombre de diffusion"),
            const SizedBox(height: 10),
            TextFormFieldwidget(
              hintText: "5",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Veuillez entrer un nombre pour la diffusion";
                }
                return null;
              },
              onSaved: (value) {},
            ),
            const SizedBox(height: 20),
            _titltText("Intervale de diffusion"),
            const SizedBox(height: 10),
            TextFormFieldwidget(
              hintText: "15",
              validator: (value) {
                if (value!.isEmpty) {
                  return "Veuillez entrer une interval de diffusion";
                }
                return null;
              },
              onSaved: (value) {},
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Action pour le bouton d'inscription
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
                "Ajouter",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
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
