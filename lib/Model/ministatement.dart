// To parse this JSON data, do
//
//     final statement = statementFromJson(jsonString);

import 'dart:convert';

List<Statement> statementFromJson(String str) => List<Statement>.from(json.decode(str).map((x) => Statement.fromJson(x)));

String statementToJson(List<Statement> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Statement {
  Statement({
    this.date,
    this.billType,
    this.credit,
    this.refNumber,
    this.debit,
  });

  DateTime date;
  String billType;
  int credit;
  String refNumber;
  int debit;

  factory Statement.fromJson(Map<String, dynamic> json) => Statement(
    date: DateTime.parse(json["date"]),
    billType: json["bill_type"],
    credit: json["credit"],
    refNumber: json["ref_number"],
    debit: json["debit"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "bill_type": billTypeValues.reverse[billType],
    "credit": credit,
    "ref_number": refNumber,
    "debit": debit,
  };
}

enum BillType { BILL, PAYMENT }

final billTypeValues = EnumValues({
  "Bill": BillType.BILL,
  "Payment": BillType.PAYMENT
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
