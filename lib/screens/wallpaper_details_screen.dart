import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pr;
import 'package:http/http.dart' as http;
import '../models/favorite_wallpaper_model.dart';
import '../models/wallpaper.dart';
import '../services/database_service.dart';

Future<void> downloadImage(String url) async {
  final response = await http.get(Uri.parse(url));

  final imageName = path.basename(url);
  final appDir = await pr.getApplicationDocumentsDirectory();
  final localPath = path.join(appDir.path, imageName);
  final imageFile = File(localPath);
  await imageFile.writeAsBytes(response.bodyBytes);
}

class WallpaperDetailsScreen extends StatefulWidget {
  final Wallpaper wallpaper;

  const WallpaperDetailsScreen({super.key, required this.wallpaper});

  @override
  State<WallpaperDetailsScreen> createState() => _WallpaperDetailsScreenState();
}

class _WallpaperDetailsScreenState extends State<WallpaperDetailsScreen> {
  bool isFavorite = false;

  _WallpaperDetailsScreenState();

  double? screenHeight;
  double? screenWidth;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  Future<void> checkFavoriteStatus() async {
    final favoriteWallpapers = await DatabaseProvider.getAllFavoriteWallpapers();
    setState(() => isFavorite = favoriteWallpapers.any((favWallpaper) => favWallpaper.id == widget.wallpaper.id));
  }

  Future<void> addToFavorites() async {
    final favoriteWallpaper = FavoriteWallpaper(
      id: widget.wallpaper.id,
      imageUrl: widget.wallpaper.imageUrl,
    );
    await DatabaseProvider.insertFavoriteWallpaper(favoriteWallpaper);
    setState(() => isFavorite = true);
  }

  Future<void> removeFromFavorites() async {
    await DatabaseProvider.deleteFavoriteWallpaper(widget.wallpaper.id);
    setState(() => isFavorite = false);
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xff01a081), title: const Text('Wallpaper Details')),
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Column(
          children: [
            SizedBox(height: screenHeight! * 0.05),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: screenHeight! * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(widget.wallpaper.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: const Icon(Icons.download), onPressed: () => downloadImage(widget.wallpaper.imageUrl)),
                IconButton(
                  icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border, color: isFavorite ? Colors.red : null),
                  onPressed: () => isFavorite ? removeFromFavorites() : addToFavorites(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
