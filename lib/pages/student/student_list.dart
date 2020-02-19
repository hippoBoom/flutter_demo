import 'package:flutter/material.dart';
import 'package:flutter_app/models/student_model.dart';
import 'package:flutter_app/pages/student/studen_detail.dart';
import 'package:flutter_app/pages/student/student_list_item.dart';
import 'package:flutter_app/service/http_request.dart';

class StudentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text('学员Todos'),
        ),
        body: StudentTodo());
  }
}

class StudentTodo extends StatefulWidget {
  @override
  _StudentTodoState createState() => _StudentTodoState();
}

class _StudentTodoState extends State<StudentTodo> {
  List<StudentItem> studentItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpRequest.request('/studentList')
        .then((res) {
      final studentTodos = res.data["data"]["list"];
//      map -> model对象 类型思维 面向对象核心思维把数据封装成模型对象

      List<StudentItem> students = [];
      for (var sub in studentTodos) {
        students.add(StudentItem.fromMap(sub));
      }

      setState(() {
        this.studentItems = students;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      /*
      静态数据ListView()
       动态数据 具名构造函数
    */
      child: ListView.builder(
          /*
        坑1： 默认 studentItems为空数组 数据获取到需要同步
        */
          itemCount: studentItems.length,
          itemBuilder: (BuildContext context, int index) {
//            传递参数
            return GestureDetector(
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => StudentDetail(studentItems[index]))),
              child: StudentListItem(studentItems[index]),
            );
          }),
    );
  }
}
