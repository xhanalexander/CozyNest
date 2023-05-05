import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../themes/constant.dart';

class LoadCards extends StatelessWidget {
  const LoadCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          Container(
            width: 150,
            height: 210,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: radiusBorder,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 150,
            height: 210,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: radiusBorder,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            width: 150,
            height: 210,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: radiusBorder,
            ),
          ),
        ],
      )
    );
  }
}

class ErrorCard extends StatelessWidget {
  const ErrorCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Icon(Icons.wifi_off_rounded, color: Colors.grey, size: 50),
        SizedBox(height: 10),
        Text("Failed to load data check your connection or refresh", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}