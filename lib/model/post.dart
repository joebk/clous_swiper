import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromMap(x)));

class Post {
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.pris,
    required this.body,
    required this.imageAsset,
    required this.name,
    required this.m2,
  });

  int userId;
  int id;
  String title;
  String body;
  String pris;
  String imageAsset;
  String name;
  String m2;

  factory Post.fromMap(Map<String, dynamic> json) => Post(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
        name: "Vendersgade 31B",
        pris: "4.800.000",
        m2: "73 m2",
        imageAsset: "assets/images/avatar_1.png"
      );
}