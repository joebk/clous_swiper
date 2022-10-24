import 'package:dating_app/model/house.dart';

class AppData {
  static final _appData = AppData._internal();
  
  bool cardOpen = false;
  String text = '2000';
  List<House> favotitter = [];

  factory AppData() {
    return _appData;
  }

  AppData._internal();
}

final appData = AppData();

