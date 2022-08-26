import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hive_basic_usage/user_model.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ShowUsers extends StatefulWidget {
  const ShowUsers({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowUsers> createState() => _ShowUsersState();
}

class _ShowUsersState extends State<ShowUsers> {
  late Box<Users> usersBox;

  @override
  void initState() {
    super.initState();
    usersBox = Hive.box('user_data');
    print(usersBox.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('Hive Basic Usage'),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: usersBox.listenable(),
        builder: (context, Box<Users> box, _) {
          List<Users> users = box.values.toList().cast<Users>();

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              Users user = users[index];

              return Container(
                alignment: Alignment.center,
                height: 90,
                margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 6,
                      spreadRadius: 5,
                      color: Colors.deepPurple.shade200.withOpacity(.3),
                    ),
                  ],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(user.userAvatarUrl),
                  ),
                  title: Text(user.userName),
                  subtitle: Text(user.userPassword),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () {
                          usersBox.delete(user.userName);
                        },
                        icon: Icon(
                          CupertinoIcons.delete,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
