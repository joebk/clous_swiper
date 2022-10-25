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
  int monthlyExpense;
  //String description;
  ////String descriptionTitel;
  ////String nextOpenHouse;
  //int priceChangePercentage;
  ////int downPayment;
  //int yearBuilt;
  //int perAreaPrice;
  //double coordinatesLat;
  //double coordinatesLon;
  
  House({
        required this.pris,
        required this.name,
        required this.m2,
        required this.imageAsset,
        required this.daysOnMarket,
        required this.numberOfRooms,
        required this.caseUrl,
        required this.images,
        required this.amountImages,
        //required this.description,
        ////required this.descriptionTitel,
        required this.monthlyExpense,
        ////required this.nextOpenHouse,
        //required this.priceChangePercentage,
        ////required this.downPayment,
        //required this.yearBuilt,
        //required this.perAreaPrice,
        //required this.coordinatesLat,
        //required this.coordinatesLon,
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
        images: imagesList,
        //description: json["descriptionBody"],
        //descriptionTitel: descriptionTitelPrep,
        monthlyExpense: json["monthlyExpense"],
        //nextOpenHouse: nextOpenHousePrep,
        //priceChangePercentage: json["priceChangePercentage"],
        //downPayment: downPaymentPrep,
        //yearBuilt: json["yearBuilt"],
        //perAreaPrice: json["perAreaPrice"],
        //coordinatesLat: json["address"]["coordinates"]["lat"],
        //coordinatesLon: json["address"]["coordinates"]["lon"]
      );
  }
}


