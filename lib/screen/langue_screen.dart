import 'package:flutter/material.dart';

class LangueScreen extends StatefulWidget {
  const LangueScreen({Key? key}) : super(key: key);

  @override
  _LangueScreenState createState() => _LangueScreenState();
}

class _LangueScreenState extends State<LangueScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestion des expressions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[],
          ),
        ),
      ),
    );
  }
}
