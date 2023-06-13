import 'package:alpha/screen/login_screen.dart';
import 'package:alpha/screen/register_screen.dart';
import 'package:flutter/material.dart';

class HomeNoconnectScreen extends StatefulWidget {
  const HomeNoconnectScreen({Key? key}) : super(key: key);

  @override
  State<HomeNoconnectScreen> createState() => _HomeNoconnectScreenState();
}

class _HomeNoconnectScreenState extends State<HomeNoconnectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/homepage.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            color: Colors.white.withOpacity(0.5),
            child: Column(
              children: <Widget>[
                const Expanded(
                    child: SizedBox(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 100),
                        child: Text(
                          'Bienvenue sur \n Alpha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                )),
                const Expanded(
                    child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text(
                            "Augmentez jusqu'à 30% votre production grâce à de l'engrais numerique ",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          )
                        ],
                      )
                    ],
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Action pour le bouton de connexion
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor:
                                Colors.transparent, // Texte en blanc
                            side: const BorderSide(
                                color: Colors.white,
                                width: 1), // Bordure blanche
                            minimumSize: const Size(
                                double.infinity, 60), // Hauteur du bouton
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rayon de 10
                            ),
                          ),
                          child: const Text(
                            'Se connecter',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16), // Espacement entre les boutons
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            // Action pour le bouton d'inscription
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green, // Texte en blanc
                            minimumSize: const Size(
                                double.infinity, 60), // Hauteur du bouton
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rayon de 10
                            ),
                          ),
                          child: const Text(
                            "S'inscrire",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
