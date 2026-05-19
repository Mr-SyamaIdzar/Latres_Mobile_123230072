import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/favorite_controller.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    final FavoriteController controller = Get.find<FavoriteController>();

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text(
          'Daftar Favorit',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.favorites.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite_border, size: 70, color: Color(0xFF666666)),
                SizedBox(height: 16),
                Text(
                  'Belum ada favorit',
                  style: TextStyle(
                    color: Color(0xFFAAAAAA),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tambahkan show favorit kamu\ndari halaman detail',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xFF666666), fontSize: 13),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: controller.favorites.length,
          itemBuilder: (context, index) {
            final show = controller.favorites[index];
            return Dismissible(
              key: Key(show.id.toString()),
              direction: DismissDirection.endToStart,
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                color: const Color(0xFFE50914),
                child: const Icon(
                  Icons.delete_outline,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              onDismissed: (_) => controller.removeFavorite(show.id),
              child: InkWell(
                onTap: () => controller.goToDetail(show.id),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF252525),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      // Thumbnail
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: show.imageMedium != null
                            ? Image.network(
                                show.imageMedium!,
                                width: 60,
                                height: 80,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) => Container(
                                  width: 60,
                                  height: 80,
                                  color: const Color(0xFF1E1E1E),
                                  child: const Icon(
                                    Icons.movie_outlined,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              )
                            : Container(
                                width: 60,
                                height: 80,
                                color: const Color(0xFF1E1E1E),
                                child: const Icon(
                                  Icons.movie_outlined,
                                  color: Color(0xFF666666),
                                ),
                              ),
                      ),
                      const SizedBox(width: 14),

                      // Info show
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              show.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star_rounded,
                                  color: Color(0xFFFFD700),
                                  size: 14,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  show.rating != null
                                      ? show.rating!.toStringAsFixed(1)
                                      : 'N/A',
                                  style: const TextStyle(
                                    color: Color(0xFFAAAAAA),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            if (show.genres.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                show.genres.take(2).join(' · '),
                                style: const TextStyle(
                                  color: Color(0xFF666666),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Tombol hapus
                      IconButton(
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Color(0xFFE50914),
                          size: 22,
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              backgroundColor: const Color(0xFF1E1E1E),
                              title: const Text(
                                'Hapus Favorit',
                                style: TextStyle(color: Colors.white),
                              ),
                              content: Text(
                                'Hapus "${show.name}" dari favorit?',
                                style: const TextStyle(
                                  color: Color(0xFFAAAAAA),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx),
                                  child: const Text(
                                    'Batal',
                                    style: TextStyle(color: Color(0xFF666666)),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(ctx);
                                    controller.removeFavorite(show.id);
                                  },
                                  child: const Text(
                                    'Hapus',
                                    style: TextStyle(color: Color(0xFFE50914)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
