import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportify/model/hotel_model.dart';
import 'package:sportify/screen/hotel_viewModel.dart';
import 'package:sportify/screen/hotel_views.dart';

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