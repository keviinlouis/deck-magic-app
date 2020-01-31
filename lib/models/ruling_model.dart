class Ruling {
  String date;
  String text;

  Ruling({this.date, this.text});

  Ruling.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['text'] = this.text;
    return data;
  }
}
