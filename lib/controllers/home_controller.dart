import 'package:get/get.dart';

import '../data/models/show.dart';
import '../data/services/tvmaze_service.dart';

class HomeController extends GetxController {
  final _service = TvMazeService();

  final shows = <Show>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchShows();
  }

  Future<void> fetchShows() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      shows.assignAll(await _service.fetchShows());
    } catch (e) {
      errorMessage.value = 'Gagal memuat data.\n$e';
    } finally {
      isLoading.value = false;
    }
  }
}
