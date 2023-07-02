import 'dart:async';

import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/dashboard_screen.dart';
import 'package:alpha/screen/widgets/view_percente.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DiffusionScreen extends StatefulWidget {
  DiffusionScreen({Key? key, required this.idDiffusion, required this.finish})
      : super(key: key);
  String idDiffusion;
  bool finish;
  @override
  _DiffusionScreenState createState() => _DiffusionScreenState();
}

class _DiffusionScreenState extends State<DiffusionScreen> {
  // AudioPlayer audioPlayer = AudioPlayer();
  int totalDuration = 0;
  int currentPosition = 0;
  final appController = Get.put(AppControler());
  // int currentMusicIndex = 1;
  late DateTime startTime;
  Duration duration = const Duration(hours: 5);
  late Timer _timer;

  String datenow = " ${DateTime.now().day}/${DateTime.now().month}";
  int _countdown = 900; // 15 minutes en secondes
  late final Stream<QuerySnapshot> streamDiffusion = FirebaseFirestore.instance
      .collection("diffusion")
      .doc(widget.idDiffusion)
      .collection("child")
      .orderBy("range", descending: false)
      .snapshots();
  late SharedPreferences prefs;
  @override
  void initState() {
    super.initState();
    appController.getuserData();
    appController.createNotification("Votre diffusion vient de commencer");
    // print(currentMusicIndex);
    // print("la valeur initiale");
    // if (prefs.getInt("numberDiffus") == 0) {
    //   print("current est 0");
    // } else {
    //   setState(() {
    //     currentMusicIndex = prefs.getInt("numberDiffus")!;
    //   });
    //   print("new valeur");
    // }
    startTime = DateTime.now();
    initializeSharedPreferences();
    if (!widget.finish) {
      playMusic();
    }
  }

  Future<void> initializeSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
    String filePath = "test-bach-wtk-1.wav";
    appController.isPlaying.value = true;
    appController.audioPlayer.value.play(AssetSource(filePath));
    appController.audioPlayer.value.onDurationChanged.listen((duration) {
      prefs.setInt("numberDiffus", 0);
      setState(() {
        totalDuration = duration.inMilliseconds;
      });
    });

    appController.audioPlayer.value.onPositionChanged.listen((position) {
      setState(() {
        currentPosition = position.inMilliseconds;
      });
    });

    appController.audioPlayer.value.onPlayerComplete.listen((event) {
      // prefs.setInt("numberDiffus", currentMusicIndex);

      appController.updateDiffusion();
      nextMusic();
    });
  }

  nextMusic() async {
    appController.percentageMusic.value = 0;
    appController.isPlaying.value = false;
    setState(() {
      currentPosition = 0;
      totalDuration = 0;
    });
    startTimer();

    Future.delayed(const Duration(minutes: 15), () {
      if (DateTime.now().difference(startTime) < duration) {
        // Appeler playMusic() pour lancer la musique suivante
        final int? counter = prefs.getInt('numberDiffus');
        print(counter! + 1);
        playMusic();
      }
    });
  }

  @override
  void dispose() {
    _cancelTimer();
    appController.audioPlayer.value.stop();
    super.dispose();
  }

  void _cancelTimer() {
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              appController.audioPlayer.value.stop();
              _cancelTimer();
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: const Color(0XFF79AD57),
        title: const Text(
          'Diffusion',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: Obx(() => Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  (appController.isPlaying.isTrue)
                      ? const Text(
                          "Votre diffusion est en cours",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )
                      : Text(
                          'Votre prochaine diffusion reprend dans ${formatTime(_countdown)}',
                          style: const TextStyle(fontSize: 20),
                          textAlign: TextAlign.center,
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 230,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: const Color(0XFF79AD57),
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

                        return ViewPercente();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  StreamBuilder(
                    stream: streamDiffusion,
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      var dataDif = snapshot.data!.docs;
                      var length = snapshot.data!.docs.length;
                      for (var element in dataDif) {
                        if (element["statut"] == "A venir") {
                          if (appController.idChild.contains(element.id)) {
                          } else {
                            appController.idChild.add(element.id);
                          }
                        }
                      }
                      return Column(
                        children: <Widget>[
                          Text(
                            'Historique du $datenow/ 2023',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: length,
                              itemBuilder: (context, index) {
                                return Column(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      title: Text(
                                        'Diffusion ${dataDif[index]["niveau"]}/$length ',
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.black54),
                                      ),
                                      trailing: (appController
                                                  .currentMusicIndex.value ==
                                              dataDif[index]["niveau"])
                                          ? (appController.isPlaying.isTrue)
                                              ? const Text(
                                                  'En diffusion',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.orange),
                                                )
                                              : const Text(
                                                  'En attente',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.orange),
                                                )
                                          : Text(
                                              "${dataDif[index]["statut"]}",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 20,
                                                  color: (dataDif[index]
                                                              ["statut"] ==
                                                          "A venir")
                                                      ? Colors.black54
                                                      : (dataDif[index]
                                                                  ["statut"] ==
                                                              "Succēs")
                                                          ? const Color(
                                                              0XFF79AD57)
                                                          : Colors.red),
                                            ),
                                    ),
                                  ],
                                );
                              })
                        ],
                      );
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      print(prefs.getInt("numberDiffus"));
                      if (appController.isPlaying.isTrue) {
                        appController.messageError(
                            "Vous ne pouvez pas quitter la diffusion");
                      } else {
                        if (appController.currentMusicIndex.value < 4) {
                          appController.messageSucces(
                              "Vous ne pouvez pas quitter la diffusion");
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) =>
                                  const DashboardScreen(),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor:
                          (appController.currentMusicIndex.value < 4)
                              ? Colors.grey
                              : const Color(0XFF79AD57), // Texte en blanc
                      minimumSize:
                          const Size(double.infinity, 60), // Hauteur du bouton
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // Rayon de 10
                      ),
                    ),
                    child: Text(
                      (!widget.finish) ? "Terminer" : "Diffusion terminée",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
