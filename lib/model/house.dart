class House {
  int pris;
  int m2;
  int daysOnMarket;
  int numberOfRooms;
  String name;
  String imageAsset;
  String caseUrl;
  List images;
  int amountImages;
  
  House({
        required this.pris,
        required this.name,
        required this.imageAsset,
        required this.m2,
        required this.daysOnMarket,
        required this.numberOfRooms,
        required this.caseUrl,
        required this.images,
        required this.amountImages
      });

  factory House.fromJson(Map<String, dynamic> json) {
    var lengthTest = json["images"].length;
    List imagesList = [];
    for (var i = 0; i < lengthTest; i++) {
        imagesList.add(json["images"][i]["imageSources"].last['url']);
    }
    return House(
        pris: json["priceCash"],
        name: json["address"]["roadName"],
        m2: json["housingArea"],
        imageAsset: json["images"].first["imageSources"].last["url"],
        daysOnMarket: json["daysOnMarket"],  
        numberOfRooms: json["numberOfRooms"],
        caseUrl: json["caseUrl"],
        amountImages: json["images"].length,
        images: imagesList
      );
  }
}

