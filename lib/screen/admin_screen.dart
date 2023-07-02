import 'package:alpha/screen/langue_screen.dart';
import 'package:alpha/screen/viewfaq_screen.dart';
import 'package:alpha/screen/viewfeedback_screen.dart';
import 'package:flutter/material.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Administration'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 20,
            ),
            adminbuton(() {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ViewfeedbackScreen(),
                ),
              );
            }, "Feedback"),
            const SizedBox(
              height: 20,
            ),
            adminbuton(() {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ViewfaqScreen(),
                ),
              );
            }, "Foire aux questions"),
            const SizedBox(
              height: 20,
            ),
            adminbuton(() {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const LangueScreen(),
                ),
              );
            }, "Langue"),
          ],
        ),
      ),
    );
  }

  Widget adminbuton(
    Function consulter,
    String tittre,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFF1A2536),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7),
            ),
            child: const Icon(
              Icons.feedback_rounded,
              color: Colors.grey,
              size: 40,
            ),
          ),
          const SizedBox(width: 25),
          TextButton(
              onPressed: () {
                consulter();
              },
              child: Text(
                tittre,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              )),
        ],
      ),
    );
  }
}
