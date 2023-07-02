import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/Actualite_screen.dart';
import 'package:alpha/screen/admin_screen.dart';
import 'package:alpha/screen/faq_screen.dart';
import 'package:alpha/screen/feedback_screen.dart';
import 'package:alpha/screen/historique.dart';
import 'package:alpha/screen/setting_screen.dart';
import 'package:alpha/screen/verifemail_screen.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final PageController _pageController = PageController();
  final appcontroler = Get.put(AppControler());
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      checkEmailVerification();
    });

    appcontroler.getuserData();
    appcontroler.getlangue();
  }

  void checkEmailVerification() async {
    if (!FirebaseAuth.instance.currentUser!.emailVerified) {
      Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const VerifemailScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tableau de bord',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.black.withBlue(30),
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const AdminScreen(),
                ),
              );
            },
            icon: const Icon(
              IconsaxOutline.security_safe,
              size: 30,
            )),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const Actualite_screen(),
                  ),
                );
              },
              icon: const Icon(
                IconsaxOutline.bookmark_2,
                size: 30,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const SettingScreen(),
                  ),
                );
              },
              icon: const Icon(
                IconsaxBold.profile_circle,
                size: 30,
                color: Colors.black,
              ))
        ],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Obx(() => SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: PageView(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() {
                          _currentIndex = index;
                        });
                      },
                      children: List.generate(
                        3,
                        (index) => Container(
                          padding: const EdgeInsets.all(25),
                          margin: const EdgeInsets.only(bottom: 5, left: 10),
                          alignment: Alignment.center,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A2536),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            appcontroler.card1.value,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.all(5),
                        height: 10,
                        width: _currentIndex == index ? 20 : 10,
                        decoration: BoxDecoration(
                          color: _currentIndex == index
                              ? Colors.black.withBlue(30)
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    appcontroler.paragraphe1.value,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      appcontroler.diffusionverif(context);
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF79AD57),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              appcontroler.lancement.value,
                              style: const TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Obx(() => Container(
                                padding: const EdgeInsets.all(25),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: (appcontroler.loaded.isTrue)
                                    ? const CircularProgressIndicator()
                                    : const Icon(
                                        Icons.podcasts,
                                        color: Colors.green,
                                        size: 70,
                                      ),
                              )),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2536),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 25),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const Historique(),
                                ),
                              );
                            },
                            child: Text(
                              appcontroler.historique.value,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A2536),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                        const SizedBox(width: 25),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      const FeedbackScreen(),
                                ),
                              );
                            },
                            child: Text(
                              appcontroler.feedback.value,
                              style: const TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => Faq_screen(),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFF929292),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_forward,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                          const SizedBox(width: 25),
                          Text(
                            appcontroler.faq.value,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
