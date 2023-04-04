import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_in/db/sqldb.dart';
import 'package:flutter_in/home/home.dart';

import 'register/register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController name = TextEditingController();
  TextEditingController password = TextEditingController();
  SqlDb sqlDb = SqlDb();
  List userDetails = [];
  @override
  void initState() {
    Login();
    // TODO: implement initState
    super.initState();
  }

  Login() async {
    userDetails = await sqlDb.readData('select * from register');
    log(userDetails.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              SizedBox(
                height: 50,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.black, fontSize: 32),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'name',
                  style: TextStyle(color: Colors.black, fontSize: 19),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Type in your name",
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'password',
                  style: TextStyle(color: Colors.black, fontSize: 19),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: password,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(17.0),
                      ),
                      filled: true,
                      hintStyle: TextStyle(color: Colors.grey[800]),
                      hintText: "Type in your password",
                      fillColor: Colors.white70),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Home()));
                    // userLogin();
                  },
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      height: 60,
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black, fontSize: 19),
                      ))),
              Container(
                  alignment: Alignment.center,
                  child: Text("or", textAlign: TextAlign.center)),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Register()));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 19),
                    ),
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  userLogin() async {
    if (userDetails.isNotEmpty) {
      for (int index in Iterable.generate(userDetails.length)) {
        if (userDetails[index]['name'].toString() == name.text.toString() &&
            userDetails[index]['password'].toString() == password.text) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }
      }
    }
  }
}