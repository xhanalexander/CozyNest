import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'hotel_viewModel.dart';
import 'dart:developer';

class HotelViews extends StatefulWidget {
  const HotelViews({super.key});

  @override
  State<HotelViews> createState() => _HotelViewsState();
}

class _HotelViewsState extends State<HotelViews> {


  @override
  void initState() {
    super.initState();
    Provider.of<HotelViewModel>(context, listen: false).getAllHotel();
  }

  @override
  Widget build(BuildContext context) {
    final modelView = Provider.of<HotelViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel List'),
        centerTitle: true,
        backgroundColor: const Color(0xff6750A4),
      ),
      body: ListView.builder(
        itemCount: modelView.hotel.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              title: Text(modelView.hotel[index].name),
              subtitle: Text(modelView.hotel[index].address),
              trailing: Text(modelView.hotel[index].description),
            ),
          );
        },
      ),
    );
  }
}