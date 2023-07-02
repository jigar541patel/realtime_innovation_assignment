

class Employee{
  int? id;
  String? strFullName;
  String? strEmployeeType;
  String? strFromDate;
  String? strToDate;

  Employee({
    this.id,
    this.strFullName,
    this.strEmployeeType,
    this.strFromDate,
    this.strToDate,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    strFullName: json["strFullName"],
    strEmployeeType: json["strEmployeeType"],
    strFromDate: json["strFromDate"],
    strToDate: json["strToDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "strFullName": strFullName,
    "strEmployeeType": strEmployeeType,
    "strFromDate": strFromDate,
    "strToDate": strToDate,
  };
}