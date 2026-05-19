import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../services/favorite_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController(), permanent: true);
  }
}
