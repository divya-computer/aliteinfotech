import 'dart:convert';

import 'package:aliteinfotech/Activity/HomePage.dart';
import 'package:aliteinfotech/Utills/Utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class AddUserInfo extends StatefulWidget {
  const AddUserInfo({super.key});

  @override
  State<AddUserInfo> createState() => _AddUserInfoState();
}

class _AddUserInfoState extends State<AddUserInfo> {
  TextEditingController etName = new TextEditingController();
  // TextEditingController etGender = new TextEditingController();
  TextEditingController etEmail = new TextEditingController();
  // TextEditingController etStatus = new TextEditingController();
  String selectedGender = '';
  String selectedstatus = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App Users Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextFormField(
                controller: etName,
                decoration: InputDecoration(
                  hintText: 'Enter Name',
                ),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'Select Gender',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                title: Text('Male'),
                leading: Radio(
                  value: 'male',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Female'),
                leading: Radio(
                  value: 'female',
                  groupValue: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              TextFormField(
                controller: etEmail,
                decoration: InputDecoration(hintText: 'Enter Email'),
              ),
              ListTile(
                title: Text('Active'),
                leading: Radio(
                  value: 'active',
                  groupValue: selectedstatus,
                  onChanged: (value) {
                    setState(() {
                      selectedstatus = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('InActive'),
                leading: Radio(
                  value: 'inactive',
                  groupValue: selectedstatus,
                  onChanged: (value) {
                    setState(() {
                      selectedstatus = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  addDetailstoApi();
                },
                child: Text('Insert Data'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addDetailstoApi() async {
    var url = Uri.parse(AppUrl.insertUserInfo);
    Map<String, String> headers = {
      'Authorization': 'Bearer ${AppUrl.userToken}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    Map<String, dynamic> requestBody = {
      'name': etName.text,
      'gender': selectedGender,
      'email': etEmail.text,
      'status': selectedstatus,
    };
    var response = await http.post(
      url,
      body: json.encode(requestBody),
      headers: headers,
    );
    if (response.statusCode == 201 || response.statusCode == 200) {
      Fluttertoast.showToast(
          msg: "Data Inserted Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      List<dynamic> jsonResponse = json.decode(response.body);
      String field = "", message = "";
      if (jsonResponse.isNotEmpty) {
        field = jsonResponse[0]['field'];
        message = jsonResponse[0]['message'];
        Fluttertoast.showToast(
            msg: "$field $message",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }

    print('Status Code : ${response.statusCode}');
    print('Status Response : ${response.body}');
  }
}
