import 'package:flutter/material.dart';
import 'package:healthcare_app/models/user.dart';
import 'package:provider/provider.dart';
import '../Providers/user_provider.dart';

class DisplayUser extends StatefulWidget {
  const DisplayUser({Key? key}) : super(key: key);

  @override
  _DisplayUserState createState() => _DisplayUserState();
}

class _DisplayUserState extends State<DisplayUser> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final List<Users> users = userProvider.users;

    return Scaffold(
      appBar: AppBar(title: Text('All Users')),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(users[index].name),
            subtitle: Text(users[index].email),
            // You can navigate to user details screen on tap
            onTap: () {
              // Navigate to user details screen and pass the selected user
            },
          );
        },
      ),
    );
  }
}
