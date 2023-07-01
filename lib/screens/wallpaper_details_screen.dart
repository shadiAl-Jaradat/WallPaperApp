import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:http/http.dart' as http;
import '../models/favorite_wallpaper_model.dart';
import '../models/wallpaper.dart';
import '../services/database_service.dart';



Future<void> downloadImage(String url) async {
  final response = await http.get(Uri.parse(url));

  // Get the image name
  final imageName = path.basename(url);
  // Get the document directory path
  final appDir = await pathProvider.getApplicationDocumentsDirectory();

  // This is the saved image path
  // You can use it to display the saved image later
  final localPath = path.join(appDir.path, imageName);

  // Downloading
  final imageFile = File(localPath);
  await imageFile.writeAsBytes(response.bodyBytes);
}
class WallpaperDetailsScreen extends StatefulWidget {
  final Wallpaper wallpaper;

  WallpaperDetailsScreen({required this.wallpaper});

  @override
  State<WallpaperDetailsScreen> createState() =>
      _WallpaperDetailsScreenState(wallpaper: wallpaper);
}

class _WallpaperDetailsScreenState extends State<WallpaperDetailsScreen> {
  final Wallpaper wallpaper;
  bool isFavorite = false;

  _WallpaperDetailsScreenState({required this.wallpaper});

  double? screenHeight;
  double? screenWidth;

  @override
  void initState() {
    super.initState();
    checkFavoriteStatus();
  }

  Future<void> checkFavoriteStatus() async {
    final favoriteWallpapers = await DatabaseProvider.getAllFavoriteWallpapers();
    setState(() {
      isFavorite = favoriteWallpapers
          .any((favWallpaper) => favWallpaper.id == wallpaper.id);
    });
  }

  Future<void> addToFavorites() async {
    final favoriteWallpaper = FavoriteWallpaper(
      id: wallpaper.id,
      imageUrl: wallpaper.imageUrl,
    );

    await DatabaseProvider.insertFavoriteWallpaper(favoriteWallpaper);

    setState(() {
      isFavorite = true;
    });
  }

  Future<void> removeFromFavorites() async {
    await DatabaseProvider.deleteFavoriteWallpaper(wallpaper.id);
    setState(() {
      isFavorite = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff01a081),
        title: Text('Wallpaper Details'),
      ),
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Column(
          children: [
            SizedBox(
              height: screenHeight! * 0.05,
            ),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: screenHeight! * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(wallpaper.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.download),
                  onPressed: () {
                    downloadImage(wallpaper.imageUrl);
                  },
                ),
                IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? Colors.red : null,
                  ),
                  onPressed: () {
                    if (isFavorite) {
                      removeFromFavorites();
                    } else {
                      addToFavorites();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
