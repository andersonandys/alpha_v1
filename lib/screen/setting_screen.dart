import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/login_screen.dart';
import 'package:alpha/screen/onboarding_screen.dart';
import 'package:alpha/screen/profile_screen.dart';
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
  @override
  void initState() {
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                      image: const DecorationImage(
                        image: AssetImage("assets/profil.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    // "${appControler.userData.value!.name} ",
                    "Anderson",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    // "${appControler.userData.value!.email} ",
                    "Anderson@gmail.com",
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            _buildListTile(
              title: "Mon compte",
              subTitle: "Profil, Telephone, Email",
              icon: IconsaxBold.profile_circle,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _buildListTile(
              title: "Culture",
              subTitle: "Tomate, Salade, Goyave",
              icon: IconsaxBold.flash_1,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _buildListTile(
              title: "Diffusion",
              subTitle: "Afficher l'historique",
              icon: Icons.podcasts_rounded,
              onTap: () {},
            ),
            const SizedBox(height: 20),
            _buildListTile(
              title: "Feedback",
              subTitle: "Afficher l'historique",
              icon: Icons.feedback_rounded,
              onTap: () {},
            ),
            const Spacer(),
            const Text(
              "Paramètres de données",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.push(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const LoginScreen(),
                    ),
                  );
                },
                child: const Text(
                  "Deconnexion",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                )),
            const SizedBox(height: 10),
            const Text(
              "Supprimer mon compte",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 15),
          ],
        ),
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
