import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/models/student_model.dart';
import 'package:flutter_app/service/http_request.dart';

class StudentDetail extends StatelessWidget {
  final StudentItem item;

  StudentDetail(this.item);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('学员Todos'),
        ),
        body: DetailsContent());
  }
}

class DetailsContent extends StatefulWidget {
  @override
  _DetailsContentState createState() => _DetailsContentState();
}

class _DetailsContentState extends State<DetailsContent> {
  StudentDetailItem studentDetailItem = new StudentDetailItem("", "", []);

  @override
  void initState() {
    // TODO: implement
    super.initState();
    HttpRequest.request('/student/detial').then((res) {
      final detailItem = res.data["user"];
      setState(() {
        //序列化
        this.studentDetailItem = StudentDetailItem.fromMap(detailItem);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final ImageBox = studentDetailItem.imageUrl == ""
        ? Text('404')
        : Image.network(studentDetailItem.imageUrl);
    final hobbit = studentDetailItem.hobit.join(' ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        ImageBox,
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '爱好：$hobbit',
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5)),
                padding: EdgeInsets.all(8),
                child: Text(
                  studentDetailItem.remark,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
