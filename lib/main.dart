import 'package:cozynest/screen/auth/register.dart';
import 'package:cozynest/screen/hotel/hotel_viewModel.dart';
import 'package:cozynest/screen/hotel/hotel_view_List.dart';
import 'package:cozynest/screen/hotel/hotel_views.dart';
import 'package:cozynest/screen/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cozynest/themes/constant.dart';

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
          create: (context) => InnViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => LocalInnViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: Colors.white,
            colorScheme: ThemeData.light().colorScheme.copyWith(
                  primary: Colors.amber[600],
                  secondary: accentColor,
                ),
          ),
          darkTheme: ThemeData.dark(),
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          routes: {
            '/': (context) => const WelcomeApp(),
            '/homepage': (context) => const HotelViews(),
            '/list': (context) => const HotelList(),
            '/register': (context) => const RegisterPage(),
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
