import 'package:flutter/material.dart';

class Historique extends StatefulWidget {
  const Historique({Key? key}) : super(key: key);

  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historique'),
        centerTitle: true,
      ),
    );
  }
}
