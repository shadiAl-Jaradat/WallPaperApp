import 'package:flutter/foundation.dart';
import 'package:wallpaper_app/models/wallpaper.dart';
import 'package:wallpaper_app/services/api_service.dart';

class WallpaperProvider extends ChangeNotifier {
  List<Wallpaper> _wallpapers = [];

  List<Wallpaper> getWallpapers() {
    return _wallpapers;
  }

  Future<void> fetchWallpapers() async {
    _wallpapers = await ApiService.fetchRandomWallpapers();
    notifyListeners();
  }

  Future<void> searchWallpapers(String query) async {
    _wallpapers = await ApiService.searchWallpapers(query);
    notifyListeners();
  }
}
