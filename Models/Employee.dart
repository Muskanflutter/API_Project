class Employee {
  String? status;
  String? message;
  List<Data>? data;

  Employee({this.status, this.message, this.data});

  Employee.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? eid;
  String? ename;
  String? salary;
  String? department;
  String? gender;
  String? addedDatetime;

  Data(
      {this.eid,
        this.ename,
        this.salary,
        this.department,
        this.gender,
        this.addedDatetime});

  Data.fromJson(Map<String, dynamic> json) {
    eid = json['eid'];
    ename = json['ename'];
    salary = json['salary'];
    department = json['department'];
    gender = json['gender'];
    addedDatetime = json['added_datetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eid'] = this.eid;
    data['ename'] = this.ename;
    data['salary'] = this.salary;
    data['department'] = this.department;
    data['gender'] = this.gender;
    data['added_datetime'] = this.addedDatetime;
    return data;
  }
}
