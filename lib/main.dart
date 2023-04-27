import 'package:cozynest/screen/auth/login.dart';
import 'package:cozynest/screen/hotel/hotel_viewModel.dart';
import 'package:cozynest/screen/hotel/hotel_views.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HotelViewModel(),
        )
      ], 
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const LoginPage(),
          '/homepage' : (context) => const HotelViews(),
        },
      ),
    );
  }
}