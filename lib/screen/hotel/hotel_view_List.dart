import 'package:cozynest/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'hotel_viewModel.dart';

class HotelList extends StatefulWidget {
  const HotelList({super.key});

  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {

  @override
  void initState() {
    super.initState();
    Provider.of<HotelViewModel>(context, listen: false).getHotels();
  }

  @override
  Widget build(BuildContext context) {
    final modelViewList = Provider.of<HotelViewModel>(context);
    return Scaffold(
      body: ListView.builder(
        itemCount: modelViewList.hotels.take(10).length, 
        itemBuilder: (context, index) {
          return Card(
            // color: primarySecond,
            child: ListTile(
              title: Text(modelViewList.hotels[index].name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(modelViewList.hotels[index].address!, style: const TextStyle(fontSize: 14),),
            ),
          );
        },
      ),
    );
  }
}