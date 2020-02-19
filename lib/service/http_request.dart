import 'package:dio/dio.dart';
import 'http_config.dart';

class HttpRequest {
  static BaseOptions baseOptions =
      BaseOptions(baseUrl: BASE_URL, connectTimeout: TIMEOUT);

  static final dio = Dio(baseOptions);

//  create DIO 异步数据返回一个Future
  static Future request(String url,
      {String method = 'get', Map<String, dynamic> params}) async {
//    send http
    Options options = Options(method: method);
    try {
      final result =
          await dio.request(url, queryParameters: params, options: options);
      return result;
    } on DioError catch (err) {
      throw err;
    }
  }
}
