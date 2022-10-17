class Album {
  final int name;
  final int pris;
  final String test;
  final String imageAsset;

  const Album({
    required this.name,
    required this.pris,
    required this.test,
    required this.imageAsset,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['userId'],
      pris: json['id'],
      test: json['title'],
      imageAsset: json['title'],
    );
  }
}