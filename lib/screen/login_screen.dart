import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/fogetmdp_screen.dart';
import 'package:alpha/screen/register_screen.dart';
import 'package:alpha/screen/widgets/button_form_component.dart';
import 'package:alpha/screen/widgets/text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:validators/validators.dart';

import '../controllers/user_controller.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final appControler = Get.put(AppControler());

  bool seePassword = false;
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    'AKWABA',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Content de vous revoir',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 50),
                  TextField(
                    controller: appControler.mailUser.value,
                    decoration: const InputDecoration(
                      label: Text("Adresse email"),
                      prefixIcon: Icon(Icons.mail),
                      labelStyle: TextStyle(color: Colors.black),
                      disabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: appControler.password.value,
                    decoration: InputDecoration(
                      label: const Text('Mot de passe'),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            seePassword = !seePassword;
                          });
                        },
                        child: Icon(
                          seePassword
                              ? Icons.remove_red_eye
                              : Icons.visibility_off,
                          color: Colors.black,
                        ),
                      ),
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      labelStyle: const TextStyle(color: Colors.black),
                      disabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(7)),
                      ),
                    ),
                    obscureText: seePassword,
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(7.0),
                            ),
                          ),
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: const SingleChildScrollView(
                                child: ForgetPasswordScreen(),
                              ),
                            );
                          });
                    },
                    child: const Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Mot de passe oublie',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  ComponentButtonForm(
                    label: "Se connecter",
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      appControler.signIn(context);
                    },
                    controller: appControler.buttonController.value,
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    onTap: () {},
                    child: RichText(
                      text: const TextSpan(
                          text: "Pas de compte ? ",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w300),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Creer un compte',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ]),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  const Text(
                    'Ou connectez-vous avec',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 25,
                          backgroundImage: AssetImage("assets/goo.png"),
                        ),
                      ),
                      const SizedBox(width: 20),
                      GestureDetector(
                        onTap: () {},
                        child: const CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage("assets/facebook.png"),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
