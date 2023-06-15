// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:workmanager/workmanager.dart';

// class MusicPlayerApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MusicPlayerScreen(),
//     );
//   }
// }

// class MusicPlayerScreen extends StatefulWidget {
//   @override
//   _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
// }

// class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
//   final List<String> musicList = [
//     // Liste des fichiers de musique à lire
//     'music1.mp3',
//     'music2.mp3',
//     'music3.mp3',
//     // Ajoutez plus de musiques si nécessaire
//   ];

//   int currentMusicIndex = 0;
//   AudioPlayer audioPlayer = AudioPlayer();
//   DateTime startTime;
//   Duration duration = Duration(hours: 5);

//   @override
//   void initState() {
//     super.initState();
//     configureWorkManager();
//   }

//   @override
//   void dispose() {
//     audioPlayer.stop();
//     super.dispose();
//   }

//   Future<void> playMusic() async {
//     if (currentMusicIndex < musicList.length) {
//       String musicPath = musicList[currentMusicIndex];
//       int result = await audioPlayer.play(musicPath, isLocal: true);
//       if (result == 1) {
//         print('Succès');
//       } else {
//         print('Échec');
//       }
//       currentMusicIndex++;
//     } else {
//       print('Terminé');
//     }

//     // Attendre 15 minutes (900 secondes) avant de jouer la musique suivante
//     await Future.delayed(Duration(minutes: 15));

//     // Vérifier si la durée de 5 heures est écoulée
//     if (DateTime.now().difference(startTime) < duration) {
//       // Appeler playMusic() pour lancer la musique suivante
//       playMusic();
//     }
//   }

//   void configureWorkManager() {
//     Workmanager.initialize(
//       callbackDispatcher,
//       isInDebugMode: true,
//     );

//     Workmanager.registerPeriodicTask(
//       'musicTask',
//       'musicTask',
//       frequency: Duration(hours: 7),
//     );
//   }

//   static void callbackDispatcher() {
//     Workmanager.executeTask((task, inputData) {
//       final musicPlayer = _MusicPlayer();
//       musicPlayer.playMusic();
//       return Future.value(true);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Music Player'),
//       ),
//       body: Center(
//         child: const Text('En cours de diffusion de musique...'),
//       ),
//     );
//   }
// }

// class _MusicPlayer {
//   final List<String> musicList = [
//     // Liste des fichiers de musique à lire
//     'music1.mp3',
//     'music2.mp3',
//     'music3.mp3',
//     // Ajoutez plus de musiques si nécessaire
//   ];

//   int currentMusicIndex = 0;
//   AudioPlayer audioPlayer = AudioPlayer();
//   DateTime startTime;
//   Duration duration = Duration(hours: 5);

//   Future<void> playMusic() async {
//     if (currentMusicIndex < musicList.length) {
//       String musicPath = musicList[currentMusicIndex];
//       int result = await audioPlayer.play(musicPath, isLocal: true);
//       if (result == 1) {
//         print('Succès');
//       } else {
//         print('Échec');
//       }
//       currentMusicIndex++;
//     } else {
//       print('Terminé');
//     }

//     // Attendre 15 minutes (900 secondes) avant de jouer la musique suivante
//     await Future.delayed(Duration(minutes: 15));

//     // Vérifier si la durée de 5 heures est écoulée
//     if (DateTime.now().difference(startTime) < duration) {
//       // Appeler playMusic() pour lancer la musique suivante
//       playMusic();
//     }
//   }
// }

// void main() {
//   runApp(MusicPlayerApp());
// }
