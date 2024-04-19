class TermsModel {
  int id = 0;
  String title = "";
  String content = "";
  String publishedAt = "";
  int enabled = 0;
  String createdAt = "";
  String updatedAt = "";

  TermsModel();

  TermsModel.fromJson(dynamic json) {
    id = json['id'] ?? 0;
    title = json['title'] ?? "";
    content = json['content'] ?? "";
    publishedAt = json['published_at'] ?? "";
    enabled = json['enabled'] ?? 0;
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['content'] = this.content;
    data['published_at'] = this.publishedAt;
    data['enabled'] = this.enabled;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
