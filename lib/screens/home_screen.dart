import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/screens/wallpaper_details_screen.dart';
import '../providers/app_state.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Wallpaper> wallpapers = [];

  @override
  void initState() {
    super.initState();
    final wallpaperProvider = Provider.of<WallpaperProvider>(context, listen: false);
    wallpaperProvider.fetchWallpapers();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WallpaperProvider>(
        builder: (context, wallpaperProvider, _) {
          final wallpapers = wallpaperProvider.getWallpapers();
          return GridView.builder(
            padding: const EdgeInsets.only(top:20 , right: 16, left: 16, bottom: 130),
            itemCount: wallpapers.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final wallpaper = wallpapers[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WallpaperDetailsScreen(wallpaper: wallpaper),
                    ),
                  );
                },
                child: Stack(
                  children: [
                    // Show shimmer effect while loading the image
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
                          image: CachedNetworkImageProvider(wallpaper.imageUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      );

  }


}
