import 'package:get/get.dart';
import '../models/tv_show_model.dart';
import '../services/favorite_service.dart';

class FavoriteController extends GetxController {
  final FavoriteService _favoriteService = Get.find<FavoriteService>();

  RxList<TvShow> favorites = <TvShow>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  void loadFavorites() {
    favorites.value = _favoriteService.getAllFavorites();
  }

  Future<void> removeFavorite(int showId) async {
    await _favoriteService.removeFavorite(showId);
    loadFavorites();
  }

  void goToDetail(int showId) {
    Get.toNamed('/detail', arguments: showId);
  }
}
