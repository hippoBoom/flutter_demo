import 'package:flutter/material.dart';

import 'pages/pages.dart';

class CRMApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CRM Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: HomePage(),
    );
  }
}

void main() => runApp(CRMApp());
