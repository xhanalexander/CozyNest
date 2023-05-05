import 'package:cozynest/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileAccount extends StatefulWidget {
  const ProfileAccount({super.key});

  @override
  State<ProfileAccount> createState() => _ProfileAccountState();
}

class _ProfileAccountState extends State<ProfileAccount> {
  late String displayName = "";

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
        /* actions: [
          IconButton(
            onPressed: () => isLogout(context),
            icon: const Icon(Icons.logout),
          ),
        ], */
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              children: [
                const Icon(
                  Icons.account_circle,
                  color: secondaryColor,
                  size: 128,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Username',
                    border: UnderlineInputBorder(),
                  ),
                  readOnly: true,
                  initialValue: displayName,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: UnderlineInputBorder(),
                  ),
                ),
              ],
            ),
          ]
        ),
      ),
    );
  }
}