class House {
  int pris;
  int m2;
  int daysOnMarket;
  int numberOfRooms;
  String name;
  String imageAsset;
  House({
        required this.pris,
        required this.name,
        required this.imageAsset,
        required this.m2,
        required this.daysOnMarket,
        required this.numberOfRooms,
      });

  factory House.fromJson(Map<String, dynamic> json) {
    return House(
        pris: json["priceCash"],
        name: json["address"]["roadName"],
        m2: json["housingArea"],
        imageAsset: json["images"].first["imageSources"].last["url"],
        daysOnMarket: json["daysOnMarket"],  
        numberOfRooms: json["numberOfRooms"],  
      );
  }
}

