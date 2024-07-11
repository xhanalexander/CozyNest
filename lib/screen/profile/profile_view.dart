import 'package:cozynest/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import '../../db/db_helper.dart';
import '../auth/authService.dart';

class ProfileAccount extends StatefulWidget {
  const ProfileAccount({super.key});

  @override
  State<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  late String displayName = "";
  final authService = AuthServices();
  final newUserName = TextEditingController();

  void deleteAccount(BuildContext context) async {
    final username = displayName;
    const password = "";
    const email = "";

    bool confirmed = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Account Deletion"),
          content: Text("Are you sure you want to delete your account? This action cannot be undone."),
          actions: <Widget>[
            TextButton(
              child: Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text("DELETE"),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
    if (confirmed) {
      if (await authService.deleteUser(username)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Account Deleted"),
              content: Text("Your account has been deleted."),
              actions: <Widget>[
                TextButton(
                  child: Text("OK"),
                  onPressed: () async {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/',
                      (Route<dynamic> route) => false,
                    );
                  },
                ),
              ],
            );
          },
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Delete Account failed')),
        );
      }
    }
  }


  void updateAccount() async {
    final username = displayName;
    final newUsername = newUserName.text;
    final password = "";
    final email = "";

    if (await authService.updateUser(username, password, email, newUsername)) {
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('username', newUsername);
      
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update Account successful')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Update Account failed')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = (prefs.getString('username') ?? '');
    });
  }

  Future<void> isLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/register',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Profile Settings',
          style: TextStyle(
            color: accentColor,
          ),
        ),
        iconTheme: const IconThemeData(
          color: accentColor,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: accentColor,
            height: 1.0,
          ),
        ),
      ),
      body: Form(
        child: Container(
          margin: const EdgeInsets.all(10),
          width: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Icon(
                      Icons.account_circle_rounded,
                      size: 100,
                      color: accentColor,
                    ),
                    Text(
                      displayName,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: newUserName,
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                color: accentColor,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: accentColor,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: accentColor,
                                ),
                              ),
                            ),
                            // initialValue:
                          ),
                          SizedBox(height: 20),
                          ListTile(
                            title: const Text(
                              'Delete Account',
                              style: TextStyle(
                                color: accentColor,
                              ),
                            ),
                            trailing: const Icon(
                              Icons.delete_forever_rounded,
                              color: accentColor,
                            ),
                            onTap: () {
                              deleteAccount(context);
                            },
                          ),
                        ],
                      ),
                    ),

                  ],
                ),
              ),   
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    updateAccount();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    // "Update Account",
                    "Update Account",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}