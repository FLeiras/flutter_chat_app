import 'dart:io';

class Environments {
  static String apiUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3000/api'
      : 'http://127.0.0.1:3000/api';
  static String urlSocket =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://127.0.0.1:3000';
}
