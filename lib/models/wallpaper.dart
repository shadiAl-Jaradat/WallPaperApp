class Wallpaper {
  final int id;
  final String imageUrl;
  final bool isFavorite;

  Wallpaper({required this.id, required this.imageUrl, this.isFavorite = false});

  factory Wallpaper.fromJson(Map<String, dynamic> json) => Wallpaper(id: json['id'], imageUrl: json['src']['original']);
}
