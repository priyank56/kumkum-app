import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/contact/controllers/contact_controller.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<ContactController>(builder: (logic) {
          return Center(
            child: Container(
              child: Text("4"),
            ),
          );
        }),
      ),
    );
  }
}
