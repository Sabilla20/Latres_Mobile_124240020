import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/favorite_controller.dart';
import 'detail_page.dart';
import 'widgets/poster_image.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<FavoriteController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Favorit')),
      body: Obx(() {
        if (c.favorites.isEmpty) {
          return const Center(
            child: Text('Belum ada show favorit',
                style: TextStyle(color: Colors.white60)),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: c.favorites.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final show = c.favorites[i];
            return Material(
              color: Colors.grey.shade900,
              borderRadius: BorderRadius.circular(10),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () => Get.to(() => DetailPage(showId: show.id)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 56,
                      height: 76,
                      child: PosterImage(url: show.imageMedium),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            show.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  color: Colors.amber, size: 14),
                              const SizedBox(width: 4),
                              Text(show.ratingText,
                                  style: const TextStyle(fontSize: 12)),
                            ],
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete,
                          color: Theme.of(context).colorScheme.primary),
                      onPressed: () => c.remove(show.id),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
