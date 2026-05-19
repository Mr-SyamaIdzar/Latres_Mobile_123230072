import 'package:get/get.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    final name = await _authService.getUsername();
    if (name != null) username.value = name;
  }

  Future<bool> login(String uname, String password) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final success = await _authService.login(uname, password);
      if (success) {
        username.value = uname;
      } else {
        errorMessage.value = 'Username dan password tidak boleh kosong';
      }
      return success;
    } catch (e) {
      errorMessage.value = 'Terjadi kesalahan: $e';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    await _authService.logout();
    username.value = '';
    Get.offAllNamed('/login');
  }
}
