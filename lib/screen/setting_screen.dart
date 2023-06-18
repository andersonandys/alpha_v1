import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/login_screen.dart';
import 'package:alpha/screen/onboarding_screen.dart';
import 'package:alpha/screen/profile_screen.dart';
import 'package:alpha/screen/settingDiffusion_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final appControler = Get.put(AppControler());
  final Stream<QuerySnapshot> streamUserProfil = FirebaseFirestore.instance
      .collection("users")
      .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots();
  @override
  void initState() {
    appControler.fetUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Paramètres',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: streamUserProfil,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(itemBuilder: ((context, index) {
            return Column(
              children: <Widget>[],
            );
          }));
        },
      ),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subTitle,
    required IconData icon,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              icon,
              size: 50,
              color: Colors.green,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                subTitle,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.arrow_forward_ios,
            color: Colors.grey,
            size: 30,
          ),
        ],
      ),
    );
  }
}
