import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class DiffusionScreen extends StatefulWidget {
  const DiffusionScreen({Key? key}) : super(key: key);

  @override
  _DiffusionScreenState createState() => _DiffusionScreenState();
}

class _DiffusionScreenState extends State<DiffusionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(
          'Diffusion',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Veuillez patienter Lorem Ipsum is simply dummy typesetting industry",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(30)),
                  child: CircularPercentIndicator(
                    backgroundWidth: 30,
                    startAngle: 180,
                    radius: 100.0,
                    lineWidth: 16.0,
                    animation: true,
                    percent: 0.75,
                    center: RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: '75 %\n',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Colors.white),
                          ),
                          TextSpan(
                              text: 'En cours...',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                    circularStrokeCap: CircularStrokeCap.round,
                    progressColor: Colors.green,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Historique du Mercredi 14 juin 2023',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                const ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'Diffusion 1/3',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  trailing: Text(
                    'Succès',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'Diffusion 2/3',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  trailing: Text(
                    'En cours',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                ),
                const ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'Diffusion 3/3',
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                  trailing: Text(
                    "A venir",
                    style: TextStyle(fontSize: 20, color: Colors.black54),
                  ),
                )
              ],
            )),
            ElevatedButton(
              onPressed: () {
                // Action pour le bouton d'inscription
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const RegisterScreen(),
                //   ),
                // );
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
                "Terminer",
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
