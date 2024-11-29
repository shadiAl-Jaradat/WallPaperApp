class FavoriteWallpaper {
  final int id;
  final String imageUrl;

  FavoriteWallpaper({required this.id, required this.imageUrl});

  factory FavoriteWallpaper.fromMap(Map<String, dynamic> map) => FavoriteWallpaper(id: map['id'], imageUrl: map['imageUrl']);

  Map<String, dynamic> toMap() => {'id': id, 'imageUrl': imageUrl};
}
