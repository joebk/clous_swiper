class Profile {
  const Profile({
    required this.name,
    required this.pris,
    required this.test,
    required this.imageAsset,
  });
  final String name;
  final String pris;
  final String test;
  final String imageAsset;
  
  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['userId'],
      pris: json['id'],
      test: json['title'],
      imageAsset: json['title'],
    );
  }
}