import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CultureScreen extends StatefulWidget {
  const CultureScreen({Key? key}) : super(key: key);

  @override
  _CultureScreenState createState() => _CultureScreenState();
}

class _CultureScreenState extends State<CultureScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final appControler = Get.put(AppControler());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Type de culture',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Sed sit amet finibus metus. Phasellus at venenatis est. Maecenas lorem metus, ornare dapibus nibh sit amet, gravida faucibus orci.",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 30),
              _titltText("Type de culture"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                controller: appControler.nomUser.value,
                hintText: "Fruit",
              ),
              const SizedBox(height: 20),
              _titltText("Détail sur la culture"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                hintText: "Sweet Tomato",
                controller: appControler.mailUser.value,
              ),
              const SizedBox(height: 20),
              _titltText("Pays"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                hintText: "Sénégal",
                controller: appControler.numberuser.value,
              ),
              const SizedBox(height: 20),
              _titltText("Climat"),
              const SizedBox(height: 10),
              TextFormFieldwidget(
                hintText: "Tempéré",
                controller: appControler.password.value,
              ),
              const Spacer(),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 20,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  appControler.updateUser();
                },
                child: const Text(
                  "Ajouter",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titltText(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
