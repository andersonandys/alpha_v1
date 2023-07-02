import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/widgets/button_form_component.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewfaqScreen extends StatefulWidget {
  const ViewfaqScreen({Key? key}) : super(key: key);

  @override
  _ViewfaqScreenState createState() => _ViewfaqScreenState();
}

class _ViewfaqScreenState extends State<ViewfaqScreen> {
  final Stream<QuerySnapshot> faqtream = FirebaseFirestore.instance
      .collection("faq")
      .orderBy("range", descending: true)
      .snapshots();
  final appControler = Get.put(AppControler());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Foire aux questions'),
        actions: [
          IconButton(
              onPressed: () {
                Get.bottomSheet(SingleChildScrollView(
                  child: Sendfaq(),
                ));
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder(
          stream: faqtream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            var length = snapshot.data!.docs.length;
            return ListView.builder(
                itemCount: length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var dataFaq = snapshot.data!.docs[index];
                  return ListTile(
                    contentPadding: const EdgeInsets.all(2),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey.shade200,
                      child: const Icon(Icons.help_rounded),
                    ),
                    trailing: IconButton(
                        onPressed: () {
                          confirmation(dataFaq.id);
                        },
                        icon: const Icon(Icons.delete)),
                    title: Text(
                      dataFaq["titre"],
                      style: const TextStyle(fontSize: 20),
                    ),
                    subtitle: Text(
                      dataFaq["contenu"],
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                });
          },
        ),
      ),
    );
  }

  // function pour supprimer un element du faq
  confirmation(idelete) {
    Get.defaultDialog(
      title: "Confirmation",
      middleText: "Voulez vous vraiment supprimer cet element ?",
      textCancel: "Annuler",
      onConfirm: () {
        appControler.deletefaq(idelete);
        Navigator.of(context).pop();
      },
    );
  }
}

class Sendfaq extends StatefulWidget {
  const Sendfaq({Key? key}) : super(key: key);

  @override
  _SendfaqState createState() => _SendfaqState();
}

class _SendfaqState extends State<Sendfaq> {
  final appControler = Get.put(AppControler());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.all(30),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.grey, borderRadius: BorderRadius.circular(100)),
            height: 5,
            width: 50,
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            'Enregistrement de FAQ',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: appControler.faqtitre.value,
            decoration: const InputDecoration(
                hintText: "Titre FAQ",
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(7)))),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: appControler.faqcontenu.value,
            decoration: const InputDecoration(
                hintText: "Contenu FAQ",
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(7))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(7)))),
          ),
          const SizedBox(
            height: 40,
          ),
          ComponentButtonForm(
            label: "S'inscrire",
            onPressed: () async {
              FocusScope.of(context).unfocus();
              appControler.addfaq();
            },
            controller: appControler.buttonController.value,
          )
        ],
      ),
    ));
  }
}
