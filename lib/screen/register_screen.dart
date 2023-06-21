import 'dart:io';

import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/widgets/button_form_component.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool seePassword = false;
  final appControler = Get.put(AppControler());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Enregistrement de compte',
        style: TextStyle(),
      )),
      body: Obx(() => Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Expanded(
                    child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              appControler.selectifile("image");
                            },
                            child: (appControler.localPath.value.isEmpty)
                                ? const Stack(
                                    children: [
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage:
                                            AssetImage("assets/default.jpeg"),
                                      ),
                                      // Positioned(
                                      //     top: 30,
                                      //     left: 30,
                                      //     child: Icon(
                                      //       Icons.camera_alt_rounded,
                                      //       color: Colors.white,
                                      //     ))
                                    ],
                                  )
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundImage: FileImage(
                                        File(appControler.localPath.value)),
                                  ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              TextFormField(
                                controller: appControler.nomUser.value,
                                decoration: const InputDecoration(
                                    suffixIcon: Icon(
                                      IconsaxBold.user,
                                      color: Colors.black,
                                    ),
                                    hintText: "Daniel Axel",
                                    disabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7))),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(7)))),
                              )
                            ],
                          ))
                        ],
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Votre adresse mail',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: appControler.mailUser.value,
                        decoration: const InputDecoration(
                            suffixIcon: Icon(
                              Icons.mail,
                              color: Colors.black,
                            ),
                            hintText: "Daniel@kameni.me",
                            disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)))),
                      ),
                      const SizedBox(height: 30),
                      const Text(
                        'Votre mot de passe',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: appControler.password.value,
                        obscureText: seePassword,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  (seePassword)
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye,
                                  color: Colors.black,
                                )),
                            hintText: "********",
                            disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)))),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        'Confirmation du mot de passe',
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: appControler.passwordConfitm.value,
                        obscureText: seePassword,
                        style: const TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  (seePassword)
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye,
                                  color: Colors.black,
                                )),
                            hintText: "********",
                            disabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7))),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7)))),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                )),
                ComponentButtonForm(
                  label: "S'inscrire",
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    appControler.creatcompte(context);
                  },
                  controller: appControler.buttonController.value,
                )
              ],
            ),
          )),
    );
  }
}
