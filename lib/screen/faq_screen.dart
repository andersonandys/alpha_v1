import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Faq_screen extends StatefulWidget {
  @override
  _Faq_screenState createState() => _Faq_screenState();
}

class _Faq_screenState extends State<Faq_screen> {
  final Stream<QuerySnapshot> faqtream = FirebaseFirestore.instance
      .collection("faq")
      .orderBy("range", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Foire aux questions'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: StreamBuilder(
          stream: faqtream,
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
              itemCount: length,
              itemBuilder: (BuildContext context, int index) {
                var dataFaq = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: ExpansionPanelList(
                    animationDuration: const Duration(milliseconds: 1000),
                    dividerColor: Colors.red,
                    elevation: 1,
                    children: [
                      ExpansionPanel(
                        backgroundColor: Color(0xFFF4F5F9),
                        body: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            dataFaq["contenu"],
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 15,
                                letterSpacing: 0.3,
                                height: 1.3),
                          ),
                        ),
                        headerBuilder: (BuildContext context, bool isExpanded) {
                          return Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.only(bottom: 30),
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              dataFaq["titre"],
                              textAlign: TextAlign.left,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          );
                        },
                        isExpanded: itemData[index].expanded,
                      )
                    ],
                    expansionCallback: (int item, bool status) {
                      setState(() {
                        itemData[index].expanded = !itemData[index].expanded;
                      });
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  List<ItemModel> itemData = <ItemModel>[
    ItemModel(
      headerItem:
          "Pourquoi privilégier votre système a celui d'un système conventionnel ?",
      discription:
          "Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. ... Some well known derivatives include Android TV for televisions and Wear OS for wearables, both developed by Google.",
      colorsItem: Colors.black,
    ),
    ItemModel(
      headerItem:
          "Pourquoi privilégier votre système a celui d'un système conventionnel ?",
      discription:
          "Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. ... Some well known derivatives include Android TV for televisions and Wear OS for wearables, both developed by Google.",
      colorsItem: Colors.green,
    ),
    ItemModel(
      headerItem:
          "Pourquoi privilégier votre système a celui d'un système conventionnel ?",
      discription:
          "Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. ... Some well known derivatives include Android TV for televisions and Wear OS for wearables, both developed by Google.",
      colorsItem: Colors.green,
    ),
    ItemModel(
      headerItem:
          "Pourquoi privilégier votre système a celui d'un système conventionnel ?",
      discription:
          "Android is a mobile operating system based on a modified version of the Linux kernel and other open source software, designed primarily for touchscreen mobile devices such as smartphones and tablets. ... Some well known derivatives include Android TV for televisions and Wear OS for wearables, both developed by Google.",
      colorsItem: Colors.green,
    )
  ];
}

class ItemModel {
  bool expanded;
  String headerItem;
  String discription;
  Color colorsItem;

  ItemModel({
    this.expanded = false,
    required this.headerItem,
    required this.discription,
    required this.colorsItem,
  });
}
