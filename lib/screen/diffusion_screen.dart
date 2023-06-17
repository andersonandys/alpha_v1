import 'dart:async';

import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/widgets/view_percente.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiffusionScreen extends StatefulWidget {
  const DiffusionScreen({Key? key}) : super(key: key);

  @override
  _DiffusionScreenState createState() => _DiffusionScreenState();
}

class _DiffusionScreenState extends State<DiffusionScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  int totalDuration = 0;
  int currentPosition = 0;
  final appController = Get.put(AppControler());
  int currentMusicIndex = 0;
  late DateTime startTime;
  Duration duration = const Duration(hours: 5);
  late Timer _timer;
  int _countdown = 120; // 15 minutes en secondes
  @override
  void initState() {
    super.initState();
    startTime = DateTime.now();
    playMusic();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_countdown > 0) {
          _countdown--;
        } else {
          // Minuterie expirée, exécuter la fonction souhaitée ici
          onTimerExpired();
          _timer.cancel();
        }
      });
    });
  }

  void onTimerExpired() {
    // Fonction à exécuter après l'expiration de la minuterie
    print("Minuterie expirée, exécution de la fonction...");
    // Relancez ici la fonction que vous souhaitez exécuter après l'expiration de la minuterie
  }

  String formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  Future<void> playMusic() async {
    if (appController.isPlaying.isTrue) return;
    String filePath = 'm2.mp3';
    appController.isPlaying.value = true;
    audioPlayer.play(AssetSource(filePath));
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        totalDuration = duration.inMilliseconds;
      });
    });

    audioPlayer.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position.inMilliseconds;
      });
    });

    audioPlayer.onPlayerComplete.listen((event) {
      print("La musique a fini de jouer");
      continu();
    });
  }

  continu() async {
    print(currentMusicIndex);
    appController.percentageMusic.value = 0;
    appController.isPlaying.value = false;
    setState(() {
      currentMusicIndex++;
      currentPosition = 0;
      totalDuration = 0;
    });
    startTimer();
    Future.delayed(const Duration(minutes: 2), () {
      currentMusicIndex++; // Passer à la musique suivante

      if (DateTime.now().difference(startTime) < duration) {
        // Appeler playMusic() pour lancer la musique suivante
        playMusic();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    audioPlayer.stop();
    super.dispose();
  }

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
                (appController.isPlaying.isTrue)
                    ? const Text(
                        "Votre diffusion est en cours",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      )
                    : Text(
                        'Votre prochaine diffusion reprend dans ${formatTime(_countdown)}',
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
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
                  child: StreamBuilder<int>(
                    stream: Stream.periodic(const Duration(milliseconds: 200),
                        (_) => currentPosition),
                    builder:
                        (BuildContext context, AsyncSnapshot<int> snapshot) {
                      double progress = totalDuration != 0
                          ? currentPosition.toDouble() /
                              totalDuration.toDouble()
                          : 0;

                      appController.percentageMusic.value =
                          progress.isFinite ? (progress * 100).toInt() : 0;
                      ;
                      return ViewPercente();
                    },
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Column(
                  children: <Widget>[
                    Text(
                      'Historique du  17 Juin 2023 ',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        'Diffusion 1/3',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                      trailing: Text(
                        'Succēs',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    ),
                    ListTile(
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
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        'Diffusion 3/3',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                      trailing: Text(
                        'Avenir',
                        style: TextStyle(fontSize: 20, color: Colors.black54),
                      ),
                    )
                  ],
                ),
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
