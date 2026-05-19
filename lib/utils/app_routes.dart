import 'package:get/get.dart';
import '../views/pages/login_page.dart';
import '../views/pages/main_page.dart';
import '../views/pages/detail_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String main = '/main';
  static const String detail = '/detail';

  static List<GetPage> pages = [
    GetPage(name: login, page: () => const LoginPage()),
    GetPage(name: main, page: () => const MainPage()),
    GetPage(name: detail, page: () => const DetailPage()),
  ];
}
