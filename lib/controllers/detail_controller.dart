import 'package:get/get.dart';

import '../data/models/show.dart';
import '../data/services/tvmaze_service.dart';

class DetailController extends GetxController {
  final int showId;
  DetailController(this.showId);

  final _service = TvMazeService();

  final show = Rxn<Show>();
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      show.value = await _service.fetchShowDetail(showId);
    } catch (e) {
      errorMessage.value = 'Gagal memuat detail.\n$e';
    } finally {
      isLoading.value = false;
    }
  }
}
