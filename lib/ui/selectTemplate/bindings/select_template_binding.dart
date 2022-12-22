import 'package:get/get.dart';
import '../controllers/select_template_controller.dart';

class SelectTemplateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectTemplateController>(
          () => SelectTemplateController(),
    );
  }
}
