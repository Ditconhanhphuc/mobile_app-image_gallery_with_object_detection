class PixabayImage {
  final String imageUrl;

  PixabayImage({required this.imageUrl});

  factory PixabayImage.fromJson(Map<String, dynamic> json) {
    return PixabayImage(
      imageUrl: json['webformatURL'],
    );
  }
}
