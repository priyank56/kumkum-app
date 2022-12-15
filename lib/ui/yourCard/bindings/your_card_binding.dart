import 'package:get/get.dart';
import '../controllers/your_card_controller.dart';

class YourCardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<YourCardsController>(
          () => YourCardsController(),
    );
  }
}
