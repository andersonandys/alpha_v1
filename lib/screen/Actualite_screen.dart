import 'package:alpha/screen/new_widget.dart';
import 'package:flutter/material.dart';

class Actualite_screen extends StatelessWidget {
  const Actualite_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Actualités',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: EdgeInsets.all(25),
        itemBuilder: (context, index) {
          return NewWidget();
        },
        separatorBuilder: (context, index) => const SizedBox(
          height: 15,
        ),
        itemCount: 5,
      ),
    );
  }
}
