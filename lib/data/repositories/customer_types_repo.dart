// import 'dart:io';

// import 'package:delicious_inventory_system/data/api_services/apis.dart';
// import 'package:delicious_inventory_system/data/models/models.dart';
// import 'package:dio/dio.dart';

// import 'repositories.dart';

// class CustomerTypesRepo {
//   List<CustomerTypeModel> _customerTypes = [];
//   final CustomerTypeAPI _customerTypeAPI = CustomerTypeAPI();
//   final String _token = AuthRepository().currentUser.token;

//   List<CustomerTypeModel> get customerTypes => _customerTypes;

//   Future<void> getAllCustomerType(Map<String, dynamic>? params) async {
//     Response response;
//     try {
//       response =
//           await _customerTypeAPI.getAllCustomerType(_token, params: params);
//       _customerTypes = List<CustomerTypeModel>.from(
//         response.data['data'].map(
//           (e) => CustomerTypeModel.fromJson(e),
//         ),
//       );
//     } on HttpException catch (e) {
//       throw HttpException(e.message);
//     }
//   }

//   Future<String> addNewCustType(Map<String, dynamic> data) async {
//     Response response;
//     String message = 'Unknown error';
//     try {
//       response = await _customerTypeAPI.addNewCustomerType(_token, data: data);
//       if (response.statusCode == 201 || response.statusCode == 200) {
//         message = response.data['message'];
//         _customerTypes.add(CustomerTypeModel.fromJson(response.data['data']));
//       }
//     } on HttpException catch (e) {
//       throw HttpException(e.message);
//     }
//     return message;
//   }

//   ///Singleton factory
//   static final CustomerTypesRepo _instance = CustomerTypesRepo._internal();

//   factory CustomerTypesRepo() {
//     return _instance;
//   }

//   CustomerTypesRepo._internal();
// }
