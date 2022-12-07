import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/ui/addKankotri/controllers/add_kankotri_controller.dart';
import 'package:get/get.dart';
import '../../../utils/color.dart';

class AddKankotriScreen extends StatelessWidget {
  const AddKankotriScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<AddKankotriController>(builder: (logic) {
          return Container(
            color: CColor.theme,
          );
        }),
      ),
    );
  }
}
