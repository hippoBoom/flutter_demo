//模型可以嵌套 例子待定

class StudentItem {
  int id;
  String userName;
  int phone;
  String nickName;
  String studentName;
  List<String> labelNames;
  String grade;
  int sex;
  String avatar;
  String remark;
  int userId;
  String managerName;

  StudentItem.fromMap(Map<String, dynamic> json) {
    this.id = json["id"];
    this.userName = json["userName"];
    this.phone = json["phone"];
    this.nickName = json["nickName"];
    this.studentName = json["studentName"];
    this.labelNames = json["labelNames"].cast<String>();
    this.grade = json["grade"];
    this.sex = json["sex"];
    this.avatar = json["avatar"];
    this.remark = json["remark"];
    this.userId = json["userId"];
    this.managerName = json["managerName"];
  }
}

class StudentDetailItem {
  String imageUrl;
  String remark;
  List<String> hobit;

  StudentDetailItem.fromMap(Map<String, dynamic> json) {
    this.imageUrl = json['imageUrl'];
    this.remark = json['remark'];
    this.hobit = json["hobit"].cast<String>();
  }

  StudentDetailItem(this.imageUrl, this.remark, this.hobit);
}
