class SABBaseModel {
  SABBaseModel();
  SABBaseModel.fromJson(Map<String, Object?> json);

  Map<String, Object?> toJson() {
    return {};
  }

  String getModelName() {
    return '';
  }

  int? getModelId() {
    return null;
  }
}
