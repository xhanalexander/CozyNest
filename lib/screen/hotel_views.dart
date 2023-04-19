import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'hotel_viewModel.dart';

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
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white38,
        ),
        child: ListView.builder(
          itemCount: modelView.hotel.length,
          itemBuilder: (context, index) {
            final hotel = modelView.hotel[index];
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: const Color(0xffEADDFF),
                child: Text(hotel.name[0], style: const TextStyle(color: Color(0xff21005D), fontWeight: FontWeight.bold)),
              ),
              title: Text(hotel.name),
              subtitle: Text(hotel.address),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {});
                    }, 
                    icon: const Icon(Icons.edit),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {});
                    }, 
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {});
        }, 
        child: const Icon(Icons.add),
      ),
    );
  }
}