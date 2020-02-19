class AdminInfo {
  String avartar;
  String name;
  int time;
  String department;

  AdminInfo.fromMap(Map<String, dynamic> json) {
    this.avartar = json['avartar'];
    this.name = json['name'];
    this.time = json["time"];
    this.department = json["department"];
  }

  AdminInfo(this.avartar, this.name, this.time, this.department);
}
