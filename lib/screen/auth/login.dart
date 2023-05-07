import 'package:cozynest/screen/auth/auth_otp.dart';
import 'package:cozynest/screen/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../db/db_helper.dart';
import '../../themes/constant.dart';
import 'authService.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  late SharedPreferences login;
  bool obscureText = true;
  final authService = AuthServices();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  void loginApp() async {
    final username = nameController.text;
    final password = passController.text;
    final email = emailController.text;
    login = await SharedPreferences.getInstance();

    if (await authService.loginUser(username, password, email)) {
      login.setBool('login', false);
      login.setString('username', username);
      /* Navigator.of(context).pushNamedAndRemoveUntil(
        '/homepage',
        (Route<dynamic> route) => false,
      ); */
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const OTPCode())
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed... Wrong username or password')),
      );
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  inputForms(labelText: "Name", controller: nameController, obscureText: false, prefixIcon: Icons.person),
                  const SizedBox(height: 20),
                  passForms(labelText: "Password", controller: passController,  prefixIcon: Icons.lock),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber[600],
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          loginApp();
                        }
                      },
                      child:
                        const Text("Sign In", style: TextStyle(fontSize: 20)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account?", style: TextStyle(color: Colors.amber[600])),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => const RegisterPage(),
                              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                const begin = Offset(1.0, 0.0);
                                const end = Offset.zero;
                                const curve = Curves.ease;

                                final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                                return SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        child: const Text("Register"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget inputForms(
      {required String labelText,
      // required String hintText,
      TextEditingController? controller,
      required bool obscureText,
      required IconData prefixIcon}) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: secondaryColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: primarySecond,
        labelText: labelText,
        labelStyle: const TextStyle(color: secondaryColor),
        prefixIcon: Icon(prefixIcon, color: secondaryColor),
        // hintText: hintText,
      ),
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $labelText";
        }
        return null;
      },
    );
  }

  Widget passForms({required String labelText, required TextEditingController controller, required IconData prefixIcon}) {
    return TextFormField(
      controller: controller,
      style: TextStyle(color: Colors.amber[600]),
      decoration: InputDecoration(
        filled: true,
        fillColor: primarySecond,
        labelText: labelText,
        labelStyle: const TextStyle(color: secondaryColor),
        prefixIcon: const Icon(Icons.lock, color: secondaryColor),
        suffixIcon: IconButton(
          icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off, color: secondaryColor),
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          }, 
        ),

      ),
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter your $labelText";
        }
        return null;
      },
    );
  }
}