import 'package:get/get.dart';
import '../controllers/add_kankotri_controller.dart';

class AddKankotriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddKankotriController>(
          () => AddKankotriController(),
    );
  }
}
