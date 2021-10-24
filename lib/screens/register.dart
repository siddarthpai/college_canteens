import 'package:college_canteens/shared/conts.dart';
import 'package:college_canteens/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  Function toggleView;

  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: Text('Sign Up to Bolt Snack'),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('sign In'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 40.0),
          child: Form(
            key: _formKey,
            child: Column(children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                textInputDecoration.copyWith(hintText: 'Email'),
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Enter an email";
                  } else {
                    return null;
                  }
                },
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration:
                textInputDecoration.copyWith(hintText: 'Password'),
                validator: (val) {
                  if (val!.length < 6) {
                    return "Password should be atleast 6 chars long";
                  } else {
                    return null;
                  }
                },
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.pinkAccent,
                child: Text('Register',
                    style: TextStyle(color: Colors.white)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() => loading = true);
                    Map<String, dynamic> result = auth_register(email, password) as Map<String, dynamic>;

                  }
                },
              ),
              SizedBox(height: 12.0),
              Text(error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0))
            ]),
          )),
    );
  }
}