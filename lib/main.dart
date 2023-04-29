import 'package:cozynest/screen/auth/login.dart';
import 'package:cozynest/screen/hotel/hotel_viewModel.dart';
import 'package:cozynest/screen/hotel/hotel_view_List.dart';
import 'package:cozynest/screen/hotel/hotel_view_detail.dart';
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
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        )
      ], 
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          routes: {
            '/': (context) => const LoginPage(),
            '/homepage' : (context) => const HotelViews(),
            '/detail' : (context) => const HotelDetail(),
            '/list' : (context) => const HotelList(),
          },
        ),
      ),
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
