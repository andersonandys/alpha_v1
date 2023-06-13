import 'package:alpha/screen/widgets/button_form_component.dart';
import 'package:alpha/screen/widgets/text_form_field_widget.dart';
import 'package:ficonsax/ficonsax.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../controllers/user_controller.dart';
import 'dashboard_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final FirebaseAuth _controllerFirebase = FirebaseAuth.instance;
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  // UserController _userC = UserController();

  bool seePassword = false;

  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Enregistrement de compte',
        style: TextStyle(),
      )),
      body: Form(
        key: _formKey,
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Votre Nom',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                          suffixIcon: Icon(
                            IconsaxBold.user,
                            color: Colors.black,
                          ),
                          hintText: "Daniel Axel",
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
                  // FocusScope.of(context).unfocus();
                  // _formKey.currentState!.save();
                  // if (_formKey.currentState!.validate()) {
                  //   _formKey.currentState!.save();
                  //   _controllerFirebase
                  //       .createUserWithEmailAndPassword(
                  //           email: email, password: password)
                  //       .then((value) async {
                  //     _userC = context.read<UserController>();
                  //     await _userC.initRegisterUserData(value.user);
                  //     _buttonController.success();
                  //     await Future.delayed(const Duration(seconds: 1))
                  //         .then((value) => Navigator.pushAndRemoveUntil(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => DashboardScreen()),
                  //               (route) => false,
                  //             ));
                  //   }).catchError((onError) async {
                  //     _buttonController.error();
                  //      ScaffoldMessenger.of(context).showSnackBar(
                  //          ComponentErrorSnackBar(onError.code).build());

                  //     await Future.delayed(const Duration(seconds: 2));
                  //     _buttonController.reset();
                  //   });
                  // } else {
                  //   _buttonController.error();
                  //   await Future.delayed(const Duration(seconds: 3));
                  //   _buttonController.reset();
                  // }
                },
                controller: _buttonController,
              )
            ],
          ),
        ),
      ),
    );
  }
}
