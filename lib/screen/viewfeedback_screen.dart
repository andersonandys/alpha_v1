import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ViewfeedbackScreen extends StatefulWidget {
  const ViewfeedbackScreen({Key? key}) : super(key: key);

  @override
  _ViewfeedbackScreenState createState() => _ViewfeedbackScreenState();
}

class _ViewfeedbackScreenState extends State<ViewfeedbackScreen> {
  final Stream<QuerySnapshot> feedbackstream =
      FirebaseFirestore.instance.collection("feedback").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: feedbackstream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var length = snapshot.data!.docs.length;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: length,
                itemBuilder: (context, index) {
                  var dataFeedback = snapshot.data!.docs[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(2),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(Icons.feedback_rounded),
                    ),
                    trailing: const Text(
                      'date',
                      style: TextStyle(fontSize: 13),
                    ),
                    title: Text(
                      dataFeedback["email"],
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      dataFeedback["nom"] + "\n" + dataFeedback["message"],
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }
}
