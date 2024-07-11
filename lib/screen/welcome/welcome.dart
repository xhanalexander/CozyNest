import 'package:cozynest/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeApp extends StatefulWidget {
  const WelcomeApp({super.key});

  @override
  State<WelcomeApp> createState() => _WelcomeAppState();
}

class _WelcomeAppState extends State<WelcomeApp> {
  late SharedPreferences login;
  late bool newUser;

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    login = await SharedPreferences.getInstance();
    newUser = (login.getBool('login') ?? true);
    Future.delayed(const Duration(seconds: 3), () {
      if (!newUser) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/homepage', (Route<dynamic> route) => false
        );
      } else {
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/register', (Route<dynamic> route) => false);
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // backgroundColor: const Color(0xff372E2C),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 42),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Logo(),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: primaryThird,
            ),
          ],
        ),
      )
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/cozynest_2.png',
      width: 256,
      height: 256,
    );
  }
}
