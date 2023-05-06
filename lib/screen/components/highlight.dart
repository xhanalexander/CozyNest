import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../themes/constant.dart';
import '../hotel/hotel_view_List.dart';

class Highlight extends StatefulWidget {
  final String highlighted;
  const Highlight({super.key, required this.highlighted});

  @override
  State<Highlight> createState() => _HighlightState();
}

class _HighlightState extends State<Highlight> {
  late String _highlighted;

  @override
  void initState() {
    super.initState();
    _highlighted = widget.highlighted;
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _highlighted,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).push(
              PageRouteBuilder(
                pageBuilder: (context, animation, _) {
                  return const HotelList();
                },
                transitionsBuilder: (context, animation, _, child) {
                  return SlideTransition(position: Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation), child: child,);
                },
              ),
            );
          },
          child: const Text(
            "View All",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: accentColor,
            ),
          ),
        ),
      ],
    );
  }
}