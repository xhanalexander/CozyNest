import 'package:flutter/material.dart';
import '../hotel/hotel_view_List.dart';

class Highlights extends StatelessWidget {
  const Highlights({super.key, required this.highlighted});

  final String highlighted;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          highlighted,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
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
            "View More",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              // color: accentColor,
            ),
          ),
        ),
      ],
    );
  }
}