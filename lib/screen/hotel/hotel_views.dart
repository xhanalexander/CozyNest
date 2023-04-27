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

  /* @override
  void initState() {
    super.initState();
    Provider.of<HotelViewModel>(context, listen: false).getAllHotel();
  } */

  @override
  Widget build(BuildContext context) {
    final modelView = Provider.of<HotelViewModel>(context);
    return Scaffold(
      /* appBar: PreferredSize(
        preferredSize: const Size.fromHeight(150.0),
        child: AppBar(
          actions: [
            IconButton(
              onPressed: () {}, 
              icon: Icon(Icons.account_circle, size: 30),
            ),
          ],
        )
      ), */
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                    ),
                  ),
                  const Text("User Name"),
                ],
              )
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text("Home"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text("Logout"),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      /* body: ListView.builder(
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
      ), */
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            actions: [
              IconButton(
                onPressed: () {

                }, 
                icon: const Icon(Icons.account_circle, size: 30),
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.all(15),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Recomended",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "View More",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.only(right: 10),
                            width: 150,
                            height: 250,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue,
                            ),
                          );
                        },
                      ),

                    ),

                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Featured",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "View More",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 200,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              width: 150,
                              height: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )         
                  ],
                ),
              )
            ),
          )
        ],
      )
    );
  }
  
}