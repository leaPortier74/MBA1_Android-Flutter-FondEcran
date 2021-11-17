

class UnsplashImage{
  String id;
  String? description;
  String regularUrl;
  String fullUrl;
  String rawUrl; //For downloading image only
  String userName; //Attribution to the photographer
  String userProfileUrl; //Photographer's profile
  String? userProfileImage; //Photographer's profile image
  int likes;
  String? blurHash; //Optional
  String? downloadLocation; //Optional
  //Color? color; //Optional

  UnsplashImage({
    required this.id,
    this.description,
    required this.regularUrl,
    required this.fullUrl,
    required this.rawUrl,
    required this.userName,
    required this.userProfileUrl,
    this.userProfileImage,
    required this.likes,
    this.blurHash,
    this.downloadLocation,
    //required this.color,
  });

  factory UnsplashImage.fromJson(Map<String, dynamic> json) {
    return UnsplashImage(
      id: json['id'],
      description: json['description'],
      regularUrl: json['urls']['regular'],
      fullUrl: json['urls']['full'],
      rawUrl: json['urls']['raw'],
      userName: json['user']['username'],
      userProfileUrl: json['user']['links']['self'],
      userProfileImage: json['user']['profile_image']['small'],
      likes: json['likes'],
      blurHash: json['blur_hash'],
      downloadLocation: json['links']['download_location'],
      //color: json['color'],
    );
  }
}