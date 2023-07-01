import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/models/favorite_wallpaper_model.dart';
import 'package:wallpaper_app/services/database_service.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<FavoriteWallpaper> favoriteWallpapers = [];

  @override
  void initState() {
    super.initState();
    _fetchFavoriteWallpapers();
  }

  Future<void> _fetchFavoriteWallpapers() async {
    final favoriteWallpapers = await DatabaseProvider.getAllFavoriteWallpapers();
    setState(() {
      this.favoriteWallpapers = favoriteWallpapers;
    });
  }

  Future<void> _removeFavoriteWallpaper(int id) async {
    await DatabaseProvider.deleteFavoriteWallpaper(id);
    await _fetchFavoriteWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: favoriteWallpapers.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final favoriteWallpaper = favoriteWallpapers[index];
          return GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => WallpaperDetailsScreen(
              //       wallpaper: Wallpaper(
              //         id: favoriteWallpaper.id,
              //         imageUrl: favoriteWallpaper.imageUrl,
              //         isFavorite: true,
              //       ),
              //     ),
              //   ),
              // );
            },
            child: Stack(
              children: [
                Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(favoriteWallpaper.imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.white,
                    onPressed: () => _removeFavoriteWallpaper(favoriteWallpaper.id),
                  ),
                ),
              ],
            ),
          );
        },
      );

  }
}
