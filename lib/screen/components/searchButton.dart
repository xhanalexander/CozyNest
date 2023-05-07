import 'package:cozynest/themes/constant.dart';
import 'package:flutter/material.dart';
import '../hotel/hotel_search.dart';

class ExploreButton extends StatefulWidget {
  const ExploreButton({super.key});

  @override
  State<ExploreButton> createState() => ExploreButtonState();
}

class ExploreButtonState extends State<ExploreButton> {
  final isDarkMode = ValueNotifier<bool>(false);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            pageBuilder: (context, animation, _) {
              return const Hotelsearch();
            },
            transitionsBuilder: (context, animation, _, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: isDarkMode.value ? Colors.white60 : Colors.grey,
          ),
        ),
        elevation: 0,
        backgroundColor: isDarkMode.value ? Colors.white60 : Colors.transparent,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Center(
          child: Row(
            children: [
              Icon(
                Icons.search, 
                color: isDarkMode.value ? Colors.black : Colors.grey
              ),
              const SizedBox(width: 10),
              Text(
                "Search hotel date", 
                style: TextStyle(
                  color: isDarkMode.value ? Colors.black : Colors.grey
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}