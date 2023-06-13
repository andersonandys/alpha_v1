import 'package:alpha/screen/fogetmdp_screen.dart';
import 'package:alpha/screen/register_screen.dart';
import 'package:alpha/screen/widgets/button_form_component.dart';
import 'package:alpha/screen/widgets/text_form_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // final FirebaseAuth _controllerFirebase = FirebaseAuth.instance;
  final RoundedLoadingButtonController _buttonController =
      RoundedLoadingButtonController();

  bool seePassword = false;
  late String email, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
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
                    TextFormFieldwidget(
                      label: "Email",
                      prefixIcon: const Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Veuillez entrer votre email";
                        } else if (!isEmail(value)) {
                          return "Veuillez entrer un email valide";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        email = value!;
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormFieldwidget(
                      label: "Mot de passe",
                      obscureText: seePassword,
                      // suffixIcon: InkWell(
                      //   onTap: () {
                      //     setState(() {
                      //       seePassword = !seePassword;
                      //     });
                      //   },
                      //   child: Icon(
                      //     seePassword
                      //         ? Icons.remove_red_eye
                      //         : Icons.visibility_off,
                      //     color: Colors.black,
                      //   ),
                      // ),
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          setState(() {
                            seePassword = !seePassword;
                          });
                        },
                        icon: Icon(
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
                      onSaved: (value) {
                        password = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Veuillez entrer votre mot de passe";
                        }
                        return null;
                      },
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
                                    bottom: MediaQuery.of(context)
                                        .viewInsets
                                        .bottom),
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
                        // if (_formKey.currentState!.validate()) {
                        //   _formKey.currentState!.save();
                        //   _controllerFirebase
                        //       .signInWithEmailAndPassword(
                        //           email: email, password: password)
                        //       .then((value) async {
                        //     UserController userC =
                        //         context.read<UserController>();
                        //     userC.populateUserData(value.user);
                        //     _buttonController.success();
                        //     await Future.delayed(const Duration(seconds: 1))
                        //         .then((value) => Navigator.pushAndRemoveUntil(
                        //               context,
                        //               MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       const DashboardScreen()),
                        //               (route) => false,
                        //             ));
                        //   }).catchError((onError) async {
                        //     _buttonController.error();
                        //     await Future.delayed(const Duration(seconds: 2));
                        //     _buttonController.reset();
                        //   });
                        // } else {
                        //   _buttonController.error();
                        //   await Future.delayed(const Duration(seconds: 3));
                        //   _buttonController.reset();
                        // }
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  DashboardScreen()),
                          (route) => false,
                        );
                      },
                      controller: _buttonController,
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ),
                        );
                      },
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
      ),
    );
  }
}
