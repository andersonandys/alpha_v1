import 'package:alpha/screen/dashboard_screen.dart';
import 'package:flutter/material.dart';

class SuccesdiffusionScreen extends StatefulWidget {
  const SuccesdiffusionScreen({Key? key}) : super(key: key);

  @override
  _SuccesdiffusionScreenState createState() => _SuccesdiffusionScreenState();
}

class _SuccesdiffusionScreenState extends State<SuccesdiffusionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Diffusion terminée'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                Image.asset("assets/finishDiffusion.png"),
                const SizedBox(
                  height: 50,
                ),
                const Text("Votre diffusion pour aujourd'hui est terminée")
              ],
            )),
            ElevatedButton(
              onPressed: () {
                // Action pour le bouton de connexion
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                elevation: 0,
                foregroundColor: Colors.white,
                backgroundColor: Colors.green, // Texte en blanc
                side: const BorderSide(
                    color: Colors.white, width: 1), // Bordure blanche
                minimumSize:
                    const Size(double.infinity, 60), // Hauteur du bouton
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rayon de 10
                ),
              ),
              child: const Text(
                'Terminer',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
