class ForeignName {
  String name;
  String language;
  int multiverseId;

  ForeignName({this.name, this.language, this.multiverseId});

  ForeignName.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    language = json['language'];
    multiverseId = json['multiverseid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['language'] = this.language;
    data['multiverseid'] = this.multiverseId;
    return data;
  }
}