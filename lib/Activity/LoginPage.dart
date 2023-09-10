import 'package:aliteinfotech/Activity/HomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _email = "", _pass = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (val) =>
                        !val!.contains("@") ? "Email Id is not Valid" : null,
                    onSaved: (val) => _email = val!,
                    decoration: InputDecoration(
                        labelText: "Email", hintText: "Enter Email"),
                  ),
                  TextFormField(
                    obscureText: true,
                    onSaved: (val) => _pass = val!,
                    validator: (val) => val!.length < 6
                        ? "Password length should be Greater than 6"
                        : null,
                    decoration: InputDecoration(
                        labelText: "Password", hintText: "Enter Password"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      child: Text("Submit"),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          formKey.currentState!.save();

                          Fluttertoast.showToast(
                              msg: "Successfully Login",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        }
                      },
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
