import 'package:dio/dio.dart';
import 'package:wallpaper_app/models/wallpaper.dart';

class ApiService {
  static const String apiKey = 'AxmpPnSl94S32wIIeE21KdQVtEK1yJEfoN3sLacXQj0WpS6gfah6lZhX';
  static const String baseUrl = 'https://api.pexels.com/v1';

  static Future<List<Wallpaper>> fetchRandomWallpapers() async {
    final dio = Dio();
    dio.options.headers['Authorization'] = apiKey;

    try {
      final response = await dio.get('$baseUrl/curated?per_page=50');

      if (response.statusCode == 200) {
        final data = response.data;
        final wallpapersData = data['photos'] as List<dynamic>;
        final wallpapers = wallpapersData.map((wallpaperData) => Wallpaper.fromJson(wallpaperData)).toList();
        return wallpapers;
      } else {
        throw Exception('Failed to fetch wallpapers');
      }
    } catch (error) {
      throw Exception('Failed to fetch wallpapers: $error');
    }
  }

  static Future<List<Wallpaper>> searchWallpapers(String query) async {
    final dio = Dio();
    dio.options.headers['Authorization'] = apiKey;

    try {
      final response = await dio.get(
        '$baseUrl/search?query=$query&per_page=50',
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final wallpapersData = data['photos'] as List<dynamic>;
        final wallpapers = wallpapersData.map((wallpaperData) => Wallpaper.fromJson(wallpaperData)).toList();
        return wallpapers;
      } else {
        throw Exception('Failed to fetch wallpapers');
      }
    } catch (error) {
      throw Exception('Failed to fetch wallpapers: $error');
    }
  }
}
