class CountryModel {
  int id = 0;
  String name = "";
  String code = "";
  String telCode = "";
  String timezone = "";
  String flag = "";
  String createdAt = "";
  String updatedAt = "";
  String image = "";

  CountryModel();

  CountryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? "";
    name = json['name'] ?? "";
    image = json['image'] ?? "";
    code = json['code'] ?? "";
    telCode = json['tel_code'] ?? "";
    timezone = json['timezone'] ?? "";
    flag = json['flag'] ?? "";
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }

}
