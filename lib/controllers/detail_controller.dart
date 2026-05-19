import 'package:get/get.dart';
import '../models/tv_show_model.dart';
import '../services/tvmaze_service.dart';
import '../services/favorite_service.dart';

class DetailController extends GetxController {
  final TvMazeService _service = TvMazeService();
  final FavoriteService _favoriteService = Get.find<FavoriteService>();

  final Rx<TvShow?> show = Rx<TvShow?>(null);
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isFavorite = false.obs;

  void loadShow(int id) {
    fetchDetail(id);
  }

  Future<void> fetchDetail(int id) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await _service.fetchShowDetail(id);
      show.value = result;
      isFavorite.value = _favoriteService.isFavorite(id);
    } catch (e) {
      errorMessage.value = 'Gagal memuat detail: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> toggleFavorite() async {
    final currentShow = show.value;
    if (currentShow == null) return;

    if (isFavorite.value) {
      await _favoriteService.removeFavorite(currentShow.id);
      isFavorite.value = false;
      Get.snackbar(
        'Favorit',
        '${currentShow.name} dihapus dari favorit',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    } else {
      await _favoriteService.addFavorite(currentShow);
      isFavorite.value = true;
      Get.snackbar(
        'Favorit',
        '${currentShow.name} ditambahkan ke favorit',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 2),
      );
    }
  }
}
