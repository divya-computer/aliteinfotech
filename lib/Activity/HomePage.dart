import 'dart:convert';
import 'dart:math';

import 'package:aliteinfotech/Activity/Aboutus.dart';
import 'package:aliteinfotech/Activity/AddUserInfo.dart';
import 'package:aliteinfotech/Activity/Contactus.dart';
import 'package:aliteinfotech/Model/UserInformation.dart';
import 'package:aliteinfotech/Utills/Utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<UserData> userInfoList = [];

  @override
  void initState() {
    apiCallingForUserDetails();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Image.network(
                'https://img.freepik.com/premium-photo/luxurious-floral-elements-botanical-background-wallpaper-design-prints-3d-render_717906-525.jpg',
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.home,
              ),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person,
              ),
              title: const Text('Add Users'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddUserInfo()));
              },
            ),
            ListTile(
              leading: Icon(Icons.contacts_outlined),
              title: const Text('Contact Us'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.adb_outlined,
              ),
              title: const Text('About Us'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: userInfoList.length,
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                  leading: Image.network(
                      "https://source.unsplash.com/random/800x600?people&$index"),
                  title: Text('Name : ${userInfoList[index].name}'),
                  subtitle: Text(
                      'Email : ${userInfoList[index].email} \nGender : ${userInfoList[index].gender} \nStatus : ${userInfoList[index].status}'),
                ));
              }),
    );
  }

  void apiCallingForUserDetails() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse(AppUrl.getUserInfo);
    Map<String, String> headers = {
      'Authorization': 'Bearer ${AppUrl.userToken}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    var response = await http.get(url, headers: headers);

    // var mymap = json.encode(response.body);

    if (response.statusCode == 200 || response.statusCode == 201) {
      List<dynamic> jsonResponse = json.decode(response.body);
      userInfoList =
          jsonResponse.map((data) => UserData.fromJson(data)).toList();

      // Update the UI using the parsed data
      setState(() {});

      print('Status Code : ${response.statusCode}');
      print('Status Response : ${response.body}');
    }
    setState(() {
      isLoading = false;
    });
  }
}
