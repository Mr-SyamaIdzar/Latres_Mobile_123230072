import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/tv_show_model.dart';

class FavoriteService {
  static const String _boxName = 'favorites';

  Box<TvShow>? _box;

  Future<void> init() async {
    _box = await Hive.openBox<TvShow>(_boxName);
  }

  Box<TvShow> get box {
    if (_box == null || !_box!.isOpen) {
      throw Exception('Hive box belum dibuka. Panggil init() terlebih dahulu.');
    }
    return _box!;
  }

  Future<void> addFavorite(TvShow show) async {
    await box.put(show.id, show);
  }

  Future<void> removeFavorite(int showId) async {
    await box.delete(showId);
  }

  bool isFavorite(int showId) {
    return box.containsKey(showId);
  }

  List<TvShow> getAllFavorites() {
    return box.values.toList();
  }

  ValueListenable<Box<TvShow>> listenable() {
    return box.listenable();
  }
}
