import 'package:get/get.dart';
import '../models/tv_show_model.dart';
import '../services/tvmaze_service.dart';

class HomeController extends GetxController {
  final TvMazeService _service = TvMazeService();

  final RxList<TvShow> shows = <TvShow>[].obs;
  final RxList<TvShow> filteredShows = <TvShow>[].obs;
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShows();
  }

  Future<void> fetchShows() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await _service.fetchShows();
      shows.value = result;
      filteredShows.value = result;
    } catch (e) {
      errorMessage.value = 'Gagal memuat data: $e';
    } finally {
      isLoading.value = false;
    }
  }

  void search(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredShows.value = shows;
    } else {
      filteredShows.value = shows
          .where((s) => s.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  Future<void> refresh() async {
    await fetchShows();
  }
}
