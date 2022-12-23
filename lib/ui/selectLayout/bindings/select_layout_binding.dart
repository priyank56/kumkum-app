import 'package:get/get.dart';
import '../controllers/select_layout_controller.dart';

class SelectLayoutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectLayoutController>(
          () => SelectLayoutController(),
    );
  }
}
