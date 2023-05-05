import 'package:flutter/material.dart';
import '../hotel/hotel_search.dart';

class SearchButton extends StatelessWidget {
  const SearchButton({super.key});

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
          side: const BorderSide(color: Colors.grey),
        ),
        elevation: 0,
        backgroundColor: Colors.white60,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 40,
        child: Center(
          child: Row(
            children: const [
              Icon(Icons.search, color: Colors.grey),
              SizedBox(width: 10),
              Text("Search hotel date", style: TextStyle(color: Colors.grey)),
            ],
          )
        ),
      ),
    );
  }
}