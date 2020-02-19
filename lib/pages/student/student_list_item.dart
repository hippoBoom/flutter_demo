import 'package:flutter/material.dart';
import 'package:flutter_app/models/student_model.dart';

class StudentListItem extends StatelessWidget {
  final StudentItem item;
  String sexUrl;

  StudentListItem(this.item);

  void _judge(sex) {
    switch (sex) {
      case 0:
        sexUrl = "assets/images/student/male.png";
        break;
      case 1:
        sexUrl = "assets/images/student/female.png";
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      // 描述容器外部的属性decoration
      // 颜色 0x ff ffffff 透明度加颜色
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 10, color: Colors.grey[200]))),
      child: Column(
        //交叉轴主轴对齐方式中间对齐
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          userDetails(),
          SizedBox(height: 12),
          userLabels(),
        ],
      ),
    );
  }

  // 用户基本信息
  Widget userDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[userAvatar(), userInfo(), viewUser()],
    );
  }

  //用户头像
  Widget userAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Image.network(
        item.avatar,
        width: 100,
      ),
    );
  }

  //用户信息
  Widget userInfo() {
    this._judge(item.sex);
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[userTitle(), userBase()],
        ),
      ),
    );
  }

  //用户姓名表头
  Widget userTitle() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          item.nickName,
          style: TextStyle(
              color: Colors.black54, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          width: 5,
        ),
        Image.asset(
          sexUrl,
          width: 18,
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          item.grade,
          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
        )
      ],
    );
  }

  //用户基本信息
  Widget userBase() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '电话：${item.phone}',
          style: TextStyle(color: Color.fromARGB(255, 59, 60, 62)),
        ),
        Row(
          children: <Widget>[Text('ID：${item.id}')],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          item.remark,
          style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          textAlign: TextAlign.left,
        )
      ],
    );
  }

  //查看用户详情
  Widget viewUser() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
      child: Column(
        children: <Widget>[
          Image.asset(
            'assets/images/student/jump.png',
            width: 30,
            color: Color.fromARGB(255, 235, 170, 60),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            '查看',
            style: TextStyle(
                fontSize: 14, color: Color.fromARGB(255, 235, 170, 60)),
          )
        ],
      ),
    );
  }

  //  用户标签Widget
  Widget userLabels() {
    final labelNamesString = item.labelNames.join(" / ");
    return Container(
      padding: EdgeInsets.all(12),
      //宽度无限大 撑开容器
      width: double.infinity,
      decoration: BoxDecoration(
          color: Color(0xffeeeeee), borderRadius: BorderRadius.circular(5)),
      child: Text(
        labelNamesString,
        style: TextStyle(fontSize: 14, color: Colors.black54),
      ),
    );
  }
}
