class PixabayImage {
  PixabayImage({
    required this.previewURL,
    required this.likes,
    required this.webformatURL,
  });

  final String previewURL;
  final int likes;
  final String webformatURL;

  factory PixabayImage.fromMap(Map<String, dynamic> map) {
    return PixabayImage(
      previewURL: map['previewURL'],
      likes: map['likes'],
      webformatURL: map['webformatURL'],
    );
  }
}
