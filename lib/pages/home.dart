import 'package:flutter/material.dart';

import '../components/drawer.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('CRM Home'),
      ),
      drawer: CRMDrawer(),
      body: SignForm(),
    );
  }
}

class SignForm extends StatefulWidget {
  @override
  _SignFormState createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  final registerFormKey = GlobalKey<FormState>();
  String username, password;

  void registerForm() {
    registerFormKey.currentState.save();
    registerFormKey.currentState.validate();

    print("username:$username password:$password");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Form(
        key: registerFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
                decoration: InputDecoration(
                    icon: Icon(Icons.people), labelText: "用户名或手机号"),
                onSaved: (value) {
                  this.username = value;
                },
                validator: (value) {
                  if (value.isEmpty) {
                    return '账号不能为空！';
                  }
                  return null;
                },
                autovalidate: true),
            TextFormField(
              obscureText: true,
              decoration:
                  InputDecoration(icon: Icon(Icons.lock), labelText: "密码"),
              onSaved: (value) {
                this.password = value;
              },
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              height: 44,
              child: RaisedButton(
                color: Colors.lightGreen,
                child: Text(
                  "注 册",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: registerForm,
              ),
            )
          ],
        ),
      ),
    );
  }
}
