import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadCards extends StatelessWidget {
  const LoadCards({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      gradient: LinearGradient(
        colors: [
          Colors.white,
          Colors.grey[300]!,
          Colors.white,
        ],
        begin: const Alignment(-1, 0),
        end: const Alignment(1, 0),
        stops: const [0, 0.5, 1],
      ),
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              child: InkWell(
                onTap: () {},
                child: const SizedBox(
                  width: 150,
                  height: 200,
                )
              )
            );
          },
        ),
      ),
    );
  }
}