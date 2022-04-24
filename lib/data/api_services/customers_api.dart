import 'dart:io';

import 'package:dio/dio.dart';

import 'dio_settings.dart';

class CustomerAPI {
  Dio dio = DioSettings.dio();

  Future<Response> getAllCustomer(String token,
      {Map<String, dynamic>? params}) async {
    Response response;
    try {
      response = await dio.get(
        '/api/customer/get_all',
        queryParameters: params,
        options: Options(headers: {
          "Authorization": "Bearer " + token,
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  Future<Response> fetchCustomerInfo(String token, int customerId) async {
    Response response;
    try {
      response = await dio.get(
        '/api/customer/get_by_customer_id/$customerId',
        options: Options(
          headers: {
            "Authorization": "Bearer " + token,
          },
        ),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  Future<Response> addNewCustomer(String token,
      {required Map<String, dynamic> data}) async {
    Response response;
    try {
      response = await dio.post('/api/customer_with_user/new',
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json",
          }));
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  Future<Response> updateCustomer(
    token, {
    required int customerId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    try {
      response = await dio.put('/api/customer/update/$customerId',
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json",
          }));
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  Future<Response> updateCustomerAddress(
    token, {
    required int customerAddressId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    try {
      response =
          await dio.put('/api/customer/address/update/$customerAddressId',
              data: data,
              options: Options(headers: {
                "Authorization": "Bearer " + token,
                "Content-Type": "application/json",
              }));
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  Future<Response> deleteCustomerAddress(
    token, {
    required int customerAddressId,
  }) async {
    Response response;
    try {
      response = await dio.delete(
        '/api/customer/address/delete/$customerAddressId',
        options: Options(headers: {
          "Authorization": "Bearer " + token,
          "Content-Type": "application/json",
        }),
      );
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  Future<Response> addNewCustomerAddress(
    token, {
    required int customerId,
    required Map<String, dynamic> data,
  }) async {
    Response response;
    try {
      response = await dio.post('/api/customer/details/new/$customerId',
          data: data,
          options: Options(headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json",
          }));
    } on DioError catch (e) {
      if (e.response != null) {
        if (e.response!.data.runtimeType != String) {
          throw HttpException(e.response!.data['message']);
        } else {
          throw HttpException(
              "Error Code ${e.response!.statusCode}: ${e.response!.statusMessage}");
        }
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }

  ///Singleton factory
  static final CustomerAPI _instance = CustomerAPI._internal();

  factory CustomerAPI() {
    return _instance;
  }

  CustomerAPI._internal();
}
