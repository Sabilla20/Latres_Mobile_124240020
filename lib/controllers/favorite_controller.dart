import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../core/constants.dart';
import '../data/models/show.dart';

/// Favorit disimpan di Hive (box 'favorites', key = id show).
class FavoriteController extends GetxController {
  late final Box _box;
  final favorites = <Show>[].obs;

  @override
  void onInit() {
    super.onInit();
    _box = Hive.box(kFavoriteBox);
    _load();
  }

  void _load() {
    favorites.assignAll(
      _box.values
          .map((e) => Show.fromMap(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );
  }

  bool isFavorite(int id) => favorites.any((s) => s.id == id);

  Future<void> add(Show show) async {
    await _box.put(show.id, show.toMap());
    _load();
  }

  Future<void> remove(int id) async {
    await _box.delete(id);
    _load();
  }

  Future<void> toggle(Show show) async {
    if (isFavorite(show.id)) {
      await remove(show.id);
      Get.snackbar('Favorit', '${show.name} dihapus dari favorit',
          snackPosition: SnackPosition.BOTTOM);
    } else {
      await add(show);
      Get.snackbar('Favorit', '${show.name} ditambahkan ke favorit',
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}
