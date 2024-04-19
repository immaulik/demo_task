import 'package:demo_task/model/country_model.dart';

class CountryResponseModel {
  String profileStatus = "";
  String role = "";
  String selectedCountry = "";
  List<CountryModel> countries = <CountryModel>[];

  CountryResponseModel();

  CountryResponseModel.fromJson(Map<String, dynamic> json) {
    profileStatus = json['profile_status'] ?? "";
    role = json['role'] ?? "";
    selectedCountry = json['selected_country'].toString() ?? "";
    if (json['countries'] != null) {
      countries = <CountryModel>[];
      json['countries'].forEach((v) {
        countries.add(new CountryModel.fromJson(v));
      });
    }
  }
}
