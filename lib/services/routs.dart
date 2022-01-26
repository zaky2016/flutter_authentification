import 'package:dio/dio.dart';

Dio win() {
  Dio httpGet = Dio();

  httpGet.options.baseUrl = 'http://127.0.0.1:8000/api';
  httpGet.options.headers['accept'] = 'Application/Json';

  return httpGet;
}
