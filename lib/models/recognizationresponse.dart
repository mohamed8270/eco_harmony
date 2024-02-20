class RecognizationResponse {
  final String imgPath;

  RecognizationResponse({
    required this.imgPath,
  });

  @override
  bool operator ==(covariant RecognizationResponse other) {
    if (identical(this, other)) return true;
    return other.imgPath == imgPath;
  }

  @override
  int get hashCode => imgPath.hashCode;
}
