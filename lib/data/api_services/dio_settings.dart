import 'interceptors.dart';
import 'package:dio/dio.dart';

class DioSettings {
  final String? url;

  Dio dio() {
    return Dio(
      BaseOptions(
        baseUrl: url ?? "http://122.54.198.84:82",
        connectTimeout: 5000,
      ),
    )..interceptors.add(Logging());
  }

  DioSettings(this.url);
}
