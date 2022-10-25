import 'package:dating_app/model/house.dart';
import 'package:dating_app/widgets/card_stack_widget.dart';

class AppData {
  static final _appData = AppData._internal();
  
  bool cardOpen = false;
  String filters = '2000';
  String postnr = '2000';
  String oldFilters = '';
  List<House> favoritter = [];
  List<String> favoritterState = [];
  late Future<List<House>> futureHousetest;
  factory AppData() {
    return _appData;
  }

  AppData._internal();
}

final appData = AppData();

