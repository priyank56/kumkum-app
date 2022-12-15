import 'package:get/get.dart';
import 'package:spotify_flutter_code/ui/category/controllers/category_controller.dart';
import 'package:spotify_flutter_code/ui/contact/controllers/contact_controller.dart';
import 'package:spotify_flutter_code/ui/home/controllers/home_controller.dart';
import 'package:spotify_flutter_code/ui/yourCard/controllers/your_card_controller.dart';
import 'package:spotify_flutter_code/ui/yourCard/controllers/your_card_controller.dart';
import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
          () => MainController(),
    );
    Get.lazyPut<HomeController>(
            () => HomeController(),fenix: true
    );
    Get.lazyPut<CategoryController>(
            () => CategoryController(),fenix: true
    );
    Get.lazyPut<YourCardsController>(
            () => YourCardsController(),fenix: true
    );
    Get.lazyPut<ContactController>(
            () => ContactController(),fenix: true
    );
  }
}
