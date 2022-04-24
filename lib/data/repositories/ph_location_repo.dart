import 'dart:io';

import 'package:dio/dio.dart';

import '/data/api_services/ph_location_api.dart';
import '/data/models/models.dart';

class PhLocationRepo {
  late List<CityMunicipalityModel> _citiesMunicipalities = [];
  late List<BrgyModel> _brgys = [];

  final PhLocationApiService _phApiService = PhLocationApiService();

  List<CityMunicipalityModel> get cities =>
      [..._citiesMunicipalities]..sort((a, b) => a.name.compareTo(b.name));
  List<BrgyModel> get brgys =>
      [..._brgys..sort((a, b) => a.name.compareTo(b.name))];

  Future<void> fetchCitiesMunicipalities() async {
    String path = '/cities-municipalities.json';
    Response response;
    try {
      response = await _phApiService.fetchData(path);

      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          _citiesMunicipalities = List<CityMunicipalityModel>.from(
            response.data.map(
              (jsonCityMunicipality) =>
                  CityMunicipalityModel.fromJson(jsonCityMunicipality),
            ),
          );
        }
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  List<CityMunicipalityModel> searchCityMunicipalityByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      return _citiesMunicipalities
          .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _citiesMunicipalities;
  }

  Future<void> fetchBrgys(String cityMunicipalityCode) async {
    final path = '/cities-municipalities/$cityMunicipalityCode/barangays.json';
    Response response;
    try {
      response = await _phApiService.fetchData(path);
      if (response.statusCode == 200) {
        if (response.data.isNotEmpty) {
          _brgys = List<BrgyModel>.from(
            response.data.map(
              (jsonBrgy) => BrgyModel.fromJson(jsonBrgy),
            ),
          );
        }
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  List<BrgyModel> searchBarangaysByKeyword(String keyword) {
    if (keyword.isNotEmpty) {
      return _brgys
          .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _brgys;
  }

  ///Singleton factory
  static final PhLocationRepo _instance = PhLocationRepo._internal();

  factory PhLocationRepo() {
    return _instance;
  }

  PhLocationRepo._internal();
}
