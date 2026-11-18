import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/detail_controller.dart';
import '../controllers/favorite_controller.dart';
import 'widgets/poster_image.dart';

class DetailPage extends StatefulWidget {
  final int showId;
  const DetailPage({super.key, required this.showId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late final DetailController c;
  late final String _tag;

  @override
  void initState() {
    super.initState();
    _tag = 'detail_${widget.showId}_${DateTime.now().microsecondsSinceEpoch}';
    c = Get.put(DetailController(widget.showId), tag: _tag);
  }

  @override
  void dispose() {
    Get.delete<DetailController>(tag: _tag);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fav = Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
      ),
      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final show = c.show.value;
        if (c.errorMessage.isNotEmpty || show == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(c.errorMessage.value, textAlign: TextAlign.center),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: c.fetchDetail,
                    child: const Text('Coba lagi'),
                  ),
                ],
              ),
            ),
          );
        }

        final isFav = fav.isFavorite(show.id);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 420,
                child: PosterImage(
                  url: show.imageOriginal ?? show.imageMedium,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      show.name,
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text(show.ratingText,
                            style: const TextStyle(fontSize: 15)),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      show.genres.isEmpty ? '-' : show.genres.join(', '),
                      style: const TextStyle(color: Colors.white60),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 46,
                      child: ElevatedButton.icon(
                        onPressed: () => fav.toggle(show),
                        icon: Icon(isFav
                            ? Icons.favorite
                            : Icons.favorite_border),
                        label: Text(isFav
                            ? 'Hapus dari Favorit'
                            : 'Tambah ke Favorit'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Overview',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      show.summary.isEmpty
                          ? 'Tidak ada ringkasan.'
                          : show.summary,
                      style: const TextStyle(height: 1.4),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
