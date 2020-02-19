import 'package:flutter/material.dart';
import 'package:flutter_app/models/login_model.dart';
import 'package:flutter_app/service/http_request.dart';

import '../pages/pages.dart';

class CRMDrawer extends StatefulWidget {
  @override
  CRMDrawerState createState() => CRMDrawerState();
}

class CRMDrawerState extends State<CRMDrawer> {
  static var _isHome = true;
  static final _panels = [
    {
      'title': '学生管理',
      'isExpanded': false,
      'items': [
        {
          'title': '学员列表',
          'isSelected': false,
          'pageBuilder': (BuildContext context) => StudentList(),
        },
//        {
//          'title': 'Material',
//          'isSelected': false,
//          'pageBuilder': (BuildContext context) => WidgetMaterialPage(),
//        },
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  void _resetPanels() {
    _panels.forEach((panel) {
      panel['isExpanded'] = false;
      (panel['items'] as List).forEach((item) {
        item['isSelected'] = false;
      });
    });
  }

  void _goHome() {
    _isHome = true;

    _resetPanels();

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
            (route) => false);
  }

  void _onExpand(index, isExpanded) {
    _resetPanels();

    _panels[index]['isExpanded'] = !isExpanded;

    setState(() {});
  }

  void _onSelected(Map<String, Object> panel, Map<String, Object> item) {
    _isHome = false;

    _resetPanels();

    panel['isExpanded'] = true;
    item['isSelected'] = true;

    Navigator.of(context).push(MaterialPageRoute(builder: item['pageBuilder']));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Admin()),
          ListTile(
            onTap: _goHome,
            title: Text(
              'Home',
              style: TextStyle(fontSize: 16),
            ),
            selected: _isHome,
            dense: true,
          ),
          ExpansionPanelList(
            expansionCallback: _onExpand,
            children: _panels
                .asMap()
                .map(
                  (index, panel) =>
                  MapEntry(
                    index,
                    ExpansionPanel(
                      headerBuilder: (context, isExpanded) =>
                          ListTile(
                            onTap: () => _onExpand(index, panel['isExpanded']),
                            title: Text(
                              panel['title'],
                              style: TextStyle(fontSize: 16),
                            ),
                            selected: isExpanded,
                            dense: true,
                          ),
                      body: Container(
                        padding: EdgeInsets.only(left: 15),
                        child: Column(
                          children: (panel['items'] as List)
                              .map((item) =>
                              ListTile(
                                onTap: () => _onSelected(panel, item),
                                title: Text(item['title']),
                                selected: item['isSelected'],
                                dense: true,
                                enabled: item['pageBuilder'] != null,
                              ))
                              .toList(),
                        ),
                      ),
                      isExpanded: panel['isExpanded'],
                    ),
                  ),
            )
                .values
                .toList(),
          ),
        ],
      ),
    );
  }
}

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  AdminInfo adminInfo = new AdminInfo("", "", 0, "");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HttpRequest.request('/user/login').then((res) {
      final resAdmin = res.data["user"];
      setState(() {
        //序列化
        this.adminInfo = AdminInfo.fromMap(resAdmin);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final avatarBox = adminInfo.avartar == ""
        ? Text('404')
        : CircleAvatar(
      radius: 30,
      backgroundImage: NetworkImage(adminInfo.avartar),
      child: Container(
        alignment: Alignment(0, .5),
        width: 60,
        height: 60,
      ),
    );

    return Column(
     crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            avatarBox,
            SizedBox(
              width: 15,
            ),
            Text(
              adminInfo.name,
              style: TextStyle(fontSize: 24),
            )
          ],
        ),
        SizedBox(height: 10,),
        Text(adminInfo.department,style: TextStyle(color: Colors.grey[600]),),
        SizedBox(height: 10,),
        Text('这是您在火花星球的第${adminInfo.time}天',style: TextStyle(color: Colors.grey[600]))
      ],
    );
  }
}
