import 'package:college_canteens/services/auth.dart';
import 'package:college_canteens/shared/conts.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  Function toggleView;
  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
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
        title: Text('Sign In to Bolt Snack'),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Register'),
            onPressed: () {
              widget.toggleView();
            },
          )
        ],
      ),
      body: loading ? Center(child: Text("Loading")) : Container(
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
                  child: Text('Sign in',
                      style: TextStyle(color: Colors.white)),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);
                      //TODO: login
                      String _email = email.substring(0, email.length-4);
                      print(_email);
                      var result = await auth_signin(_email, password);
                      print("Result");
                      print(result);
                      if (result == null) {
                        setState(() {
                          error =
                          'could not log in with given credentials';
                          loading = false;
                        });}
                        else{
                          print("Result");
                          print(result['isAdmin'].runtimeType);
                          setState(() {
                            loading = false;
                          });
                          if (result['isAdmin'] == false){
                            Navigator.pushNamed(context, '/user', arguments: {'usrdata': result});
                            //Navigator.pop();
                          }
                          else if (result['isAdmin'] == true){
                            Navigator.pushNamed(context, '/admin');
                          }
                        }
                      }
                    }
                  ),
              SizedBox(height: 12.0),
              Text(error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0))
            ]),
          )),
    );
  }
}
