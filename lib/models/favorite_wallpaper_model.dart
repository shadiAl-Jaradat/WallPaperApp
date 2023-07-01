class FavoriteWallpaper {
  final int id;
  final String imageUrl;

  FavoriteWallpaper({
    required this.id,
    required this.imageUrl,
  });

  factory FavoriteWallpaper.fromMap(Map<String, dynamic> map) {
    return FavoriteWallpaper(
      id: map['id'],
      imageUrl: map['imageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'imageUrl': imageUrl,
    };
  }
}
