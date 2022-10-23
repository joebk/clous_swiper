class AppData {
  static final _appData = AppData._internal();
  
  bool test = false;
  String text = '2000';

  factory AppData() {
    return _appData;
  }

  AppData._internal();
}

final appData = AppData();

