import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/favourite/controllers/favourite_controller.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<FavouriteController>(builder: (logic) {
          return Center(
            child: Container(
              child: Text("3"),
            ),
          );
        }),
      ),
    );
  }
}
