class Postnumre {
  final int nr;

  const Postnumre({
    required this.nr,
  });

  factory Postnumre.fromJson(Map<String, dynamic> json) {
    return Postnumre(
      nr: json['nr'],
    );
  }
}