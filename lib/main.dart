import 'package:cozynest/screen/hotel_viewModel.dart';
import 'package:cozynest/screen/hotel_views.dart';
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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HotelViews(),
      ),
    );
  }
}