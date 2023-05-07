import 'package:cozynest/screen/auth/register.dart';
import 'package:cozynest/screen/hotel/hotel_viewModel.dart';
import 'package:cozynest/screen/hotel/hotel_view_List.dart';
import 'package:cozynest/screen/hotel/hotel_views.dart';
import 'package:cozynest/screen/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cozynest/main.dart';
import 'package:provider/provider.dart';

void main() {

  testWidgets('Test if all main components in Dashboard', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => HotelViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => InnViewModel(),
          ),/* 
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ), */
        ], 
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) => MaterialApp(
            initialRoute: '/homepage',
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            routes: {
              '/': (context) => WelcomeApp(),
              '/homepage' : (context) => HotelViews(),
              '/list' : (context) => HotelList(),
              '/register' : (context) => RegisterPage(),
            },
          ),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 5));

    expect(find.byType(AppBar), anything);

    expect(find.byType(Drawer), anything);

    expect(find.text('Dark Mode'), anything);

    expect(find.byWidgetPredicate((widget) => widget is Text && widget.data == 'Logout'), anything);

    expect(find.byWidgetPredicate((widget) => widget is Text && widget.data == 'Report Bug'), anything);

    expect(find.text('Welcome,'), anything);

    expect(find.text('Recomended'), anything);

    expect(find.text('Featured'), anything);
  });


}
