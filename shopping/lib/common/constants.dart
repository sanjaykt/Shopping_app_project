import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(),
);

class Constants {
  Constants();




//  static const String SERVER = 'http://172.20.10.2:3030';
//  static const String SERVER = 'http://10.110.44.136:3030';

  static const String SERVER = 'http://192.168.43.122:8080';
  static const Map<String, String> HEADER = {"Content-Type": "application/json"};
}
