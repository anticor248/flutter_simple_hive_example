import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hive_basic_usage/show_users.dart';
import 'package:hive/hive.dart';

import 'user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Box<Users> usersBox;

  @override
  void initState() {
    super.initState();
    usersBox = Hive.box('user_data');
    //print(usersBox.values);
  }

  final userNameController = TextEditingController();
  final userPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Hive Basic Usage'),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                TextField(
                  //controller let us to use inputs
                  //define controllers in class using TextEditingController();

                  controller: userNameController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.person),
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey,
                    labelText: 'User Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  //controller let us to use inputs
                  //define controllers in class using TextEditingController();

                  controller: userPasswordController,
                  obscureText: false,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(CupertinoIcons.lock),
                    border: OutlineInputBorder(),
                    fillColor: Colors.grey,
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Users user = Users(
                      // Creates a controller for an editable text field => .text after controller
                      userName: userNameController.text,
                      userPassword: userPasswordController.text,

                      //TODO chance user avatar and get from user
                      userAvatarUrl:
                          'https://cdn.dribbble.com/users/1355613/screenshots/15252730/media/28f348daf9654c440f5dcf398d8e097a.jpg?compress=1&resize=400x300&vertical=top',
                    );
                    usersBox.put(user.userName, user);

                    //For keyboard automaticly dismiss after onpress the button
                    SystemChannels.textInput.invokeMethod('TextInput.hide');

                    //no need for setstate after using Hive
                    // setState(() {
                    //   savedName = userNameController.text;
                    //   savedPassword = userPasswordController.text;
                    // });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Text('SAVE USERS'),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShowUsers(),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Text('SHOW USERS'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
