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
        Text(
          "Failed to load data check your connection or input the date bookings", 
          style: TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class LoadList extends StatelessWidget {
  const LoadList({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              
            ),
          );
        },
      ),
    );
  }
}

class FailedData extends StatelessWidget {
  const FailedData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.wifi_off_rounded, color: Colors.grey, size: 50),
            SizedBox(height: 10),
            Text("Failed to load data check your connection or input the date bookings", style: TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}

class LoadGrid extends StatelessWidget {
  const LoadGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          // itemCount: min(innViewModel.inns.length, 10),
          itemCount: 4,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.7,
          ),
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
    );
  }
}