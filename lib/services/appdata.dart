import 'package:dating_app/model/house.dart';
import 'package:dating_app/widgets/card_stack_widget.dart';

class AppData {
  static final _appData = AppData._internal();
  
  bool cardOpen = false;
  String postnr = '2000';
  double minPriceChosen = 0.0;
  double maxPriceChosen = 9000000.0;
  Map oldFilters = {};
  int seqNo = 0;
  List<House> favoritter = [];
  List<String> favoritterState = [];
  Map filters = {
    "minPrice": 0.0,
    "maxPrice": 9000000.0,
    "postnr": '2000',
    //"seqNo": 1
  };
  late Future<List<House>> futureHousetest;

  factory AppData() {
    return _appData;
  }

  AppData._internal();
}

final appData = AppData();

