// ignore: non_constant_identifier_names

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
  int? monthlyExpense;
  String? description;
  String? descriptionTitel;
  String? nextOpenHouse;
  double? priceChangePercentage;
  int? downPayment;
  int? yearBuilt;
  int? perAreaPrice;
  String? coordinatesLat;
  String? coordinatesLon;

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
        this.description,
        this.descriptionTitel,
        this.monthlyExpense,
        this.nextOpenHouse,
        this.priceChangePercentage,
        this.downPayment,
        this.yearBuilt,
        this.perAreaPrice,
        this.coordinatesLat,
        this.coordinatesLon,
      });

  factory House.fromJson(Map<String, dynamic> json) {
    var lengthTest = json["images"].length;
    List imagesList = [];
    for (var i = 0; i < lengthTest; i++) {
        imagesList.add(json["images"][i]["imageSources"].last['url']);
    }

    int? downPayment;
    if (json.containsKey('realEstate') == true) {
      if (json.containsKey('downPayment') == true) {
        downPayment = json["realEstate"]["downPayment"];
      } else {
        downPayment = 0;
      }
    } else {
      downPayment = 0;
    }
    

    String? nextOpenHouse;
    if (json.containsKey('nextOpenHouse') == true) {
      if (nextOpenHouse.runtimeType == String) {
        nextOpenHouse = json["nextOpenHouse"];
      } else {
        nextOpenHouse = 'Ukendt';
      }
    } else {
      nextOpenHouse = 'Ukendt';
    }

    double? priceChangePercentage;
    if (json.containsKey('priceChangePercentage') == true) {
      priceChangePercentage = json["priceChangePercentage"].toDouble();
    } else {
      priceChangePercentage = 0;
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
        description: json["descriptionBody"],
        descriptionTitel: json["descriptionTitle"],
        monthlyExpense: json["monthlyExpense"],
        nextOpenHouse: nextOpenHouse,
        priceChangePercentage: priceChangePercentage,
        downPayment: downPayment,
        yearBuilt: json["yearBuilt"],
        perAreaPrice: json["perAreaPrice"],
        //coordinatesLat: coordinatesLat,
        //coordinatesLon: json["address"]["coordinates"]["lon"]
      );
  }
}

