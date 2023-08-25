// External Modules
import 'package:dio/dio.dart';

abstract class BaseRepository {
  late Dio _dio;

  Dio get dataProvider => _dio;

  BaseRepository() {
    var baseUrl = 'https://todo-list-api-mfchjooefq-as.a.run.app/';
    var options = BaseOptions(
      receiveTimeout: const Duration(seconds: 60),
      connectTimeout: const Duration(seconds: 60),
      baseUrl: baseUrl,
    );
    _dio = Dio(options);
  }
}
