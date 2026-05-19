import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../controllers/detail_controller.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late DetailController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.put(DetailController(), tag: 'detail');
    final int showId = Get.arguments as int;
    _controller.loadShow(showId);
  }

  @override
  void dispose() {
    Get.delete<DetailController>(tag: 'detail');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      body: Obx(() {
        if (_controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFE50914)),
          );
        }

        if (_controller.errorMessage.value.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Color(0xFF666666),
                  size: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  _controller.errorMessage.value,
                  style: const TextStyle(color: Color(0xFFAAAAAA)),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: Get.back,
                  child: const Text('Kembali'),
                ),
              ],
            ),
          );
        }

        final show = _controller.show.value;
        if (show == null) return const SizedBox.shrink();

        return CustomScrollView(
          slivers: [
            // AppBar dengan gambar
            SliverAppBar(
              expandedHeight: 320,
              pinned: true,
              backgroundColor: const Color(0xFF121212),
              leading: IconButton(
                icon: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                onPressed: Get.back,
              ),
              title: const Text(
                'Detail',
                style: TextStyle(color: Colors.white),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    show.imageOriginal != null || show.imageMedium != null
                        ? CachedNetworkImage(
                            imageUrl:
                                show.imageOriginal ?? show.imageMedium ?? '',
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                Container(color: const Color(0xFF1E1E1E)),
                            errorWidget: (context, url, err) => Container(
                              color: const Color(0xFF1E1E1E),
                              child: const Icon(
                                Icons.image_not_supported,
                                color: Color(0xFF666666),
                                size: 60,
                              ),
                            ),
                          )
                        : Container(color: const Color(0xFF1E1E1E)),

                    // Gradient overlay
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Color(0xFF121212),
                          ],
                          stops: [0.0, 0.5, 1.0],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Konten detail
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Judul
                    Text(
                      show.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Rating & status
                    Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: Color(0xFFFFD700),
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          show.rating != null
                              ? show.rating!.toStringAsFixed(1)
                              : 'N/A',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        if (show.status != null) ...[
                          const SizedBox(width: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: show.status == 'Running'
                                  ? Colors.green.withOpacity(0.2)
                                  : const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: show.status == 'Running'
                                    ? Colors.green
                                    : const Color(0xFF2C2C2C),
                              ),
                            ),
                            child: Text(
                              show.status!,
                              style: TextStyle(
                                color: show.status == 'Running'
                                    ? Colors.green
                                    : const Color(0xFFAAAAAA),
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Genre
                    if (show.genres.isNotEmpty) ...[
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: show.genres.map((genre) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE50914).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE50914).withOpacity(0.4),
                              ),
                            ),
                            child: Text(
                              genre,
                              style: const TextStyle(
                                color: Color(0xFFE50914),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Tombol aksi
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.play_arrow_rounded,
                              size: 22,
                            ),
                            label: const Text('Nonton'),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Obx(
                          () => Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1E1E1E),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: _controller.isFavorite.value
                                    ? const Color(0xFFE50914)
                                    : const Color(0xFF2C2C2C),
                              ),
                            ),
                            child: IconButton(
                              onPressed: _controller.toggleFavorite,
                              icon: Icon(
                                _controller.isFavorite.value
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_border_rounded,
                                color: _controller.isFavorite.value
                                    ? const Color(0xFFE50914)
                                    : const Color(0xFF666666),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Overview / summary
                    if (show.summary != null) ...[
                      const Text(
                        'Overview',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Html(
                        data: show.summary!,
                        style: {
                          'body': Style(
                            color: const Color(0xFFAAAAAA),
                            fontSize: FontSize(14),
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                          ),
                          'p': Style(color: const Color(0xFFAAAAAA)),
                        },
                      ),
                    ],

                    // Info tambahan
                    const SizedBox(height: 20),
                    if (show.premiered != null || show.language != null) ...[
                      const Divider(color: Color(0xFF2C2C2C)),
                      const SizedBox(height: 12),
                      const Text(
                        'Informasi',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (show.premiered != null)
                        _infoRow('Tayang Perdana', show.premiered!),
                      if (show.language != null)
                        _infoRow('Bahasa', show.language!),
                    ],
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          SizedBox(
            width: 130,
            child: Text(
              label,
              style: const TextStyle(color: Color(0xFF666666), fontSize: 13),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(color: Color(0xFFAAAAAA), fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
