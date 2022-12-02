import 'package:flutter/material.dart';
import 'package:spotify_flutter_code/ui/category/controllers/category_controller.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<CategoryController>(builder: (logic) {
          return Center(
            child: Container(
              child: Text("2"),
            ),
          );
        }),
      ),
    );
  }
}
