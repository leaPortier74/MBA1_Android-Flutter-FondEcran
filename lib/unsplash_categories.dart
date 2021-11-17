

class UnsplashCategories{
  String id;
  String slug;
  String title;
  String listPhotos; 
  String coverPhoto;

  UnsplashCategories({
    required this.id,
    required this.slug,
    required this.title,
    required this.listPhotos,
    required this.coverPhoto,
  });

  factory UnsplashCategories.fromJson(Map<String, dynamic> json) {
    return UnsplashCategories(
      id: json['id'],
      slug: json['slug'],
      title: json['title'],
      listPhotos: json['links']['photos'],
      coverPhoto: json['cover_photo']['urls']['small'],
    );
  }
}