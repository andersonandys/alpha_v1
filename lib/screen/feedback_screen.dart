import 'package:alpha/controllers/app_controler.dart';
import 'package:alpha/screen/widgets/button_form_component.dart';
import 'package:alpha/screen/widgets/text_form_field_widget.dart';
import 'package:ficonsax/ficonsax.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  bool seePassword = false;
  final appControler = Get.put(AppControler());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Feed-back',
            style: TextStyle(),
          )),
      body: Obx(() => Container(
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Nous apprécierons recevoir vos retours et avis. Merci de remplir ce formulaire.",
                    style: TextStyle(
                      fontSize: 19,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 30),
                  _titltText("Votre nom"),
                  const SizedBox(height: 20),
                  TextFormFieldwidget(
                    controller: appControler.nomfeed.value,
                    hintText: "David Axel",
                  ),
                  const SizedBox(height: 40),
                  _titltText("Adress e-mail"),
                  const SizedBox(height: 10),
                  TextFormFieldwidget(
                    controller: appControler.mailfeed.value,
                    hintText: "daniel@kameni.me",
                  ),
                  const SizedBox(height: 40),
                  _titltText("Message"),
                  const SizedBox(height: 10),
                  TextFormFieldwidget(
                    controller: appControler.messagefeed.value,
                    hintText: "",
                    maxLines: 8,
                    minLines: 8,
                  ),
                  const SizedBox(height: 40),
                  ComponentButtonForm(
                    label: "Envoyer",
                    onPressed: () async {
                      FocusScope.of(context).unfocus();
                      appControler.sendFeedback(context);
                    },
                    controller: appControler.buttonController.value,
                  ),
                ],
              ),
            ),
          )),
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
