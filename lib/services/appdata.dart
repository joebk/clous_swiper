import 'package:dating_app/model/house.dart';

class AppData {
  static final _appData = AppData._internal();
  
  bool cardOpen = false;
  String text = '2000';
  List<House> favotitter = [];
  List<String> favotitterState = [];

  factory AppData() {
    return _appData;
  }

  AppData._internal();
}

final appData = AppData();

