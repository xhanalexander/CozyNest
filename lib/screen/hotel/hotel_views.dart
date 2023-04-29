import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'hotel_viewModel.dart';
import 'hotel_view_List.dart';
import 'dart:developer';
import '../../main.dart';
import '../../model/hotel_model.dart';


class HotelViews extends StatefulWidget {
  const HotelViews({super.key});

  @override
  State<HotelViews> createState() => _HotelViewsState();
}

class _HotelViewsState extends State<HotelViews> {
  late String displayName = "";

  @override
  void initState() {
    super.initState();
    isLogin();
    Provider.of<HotelViewModel>(context, listen: false).getHotels();
  }

  void isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = (prefs.getString('username') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {

    final modelView = Provider.of<HotelViewModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (modelView.state == HotelState.initial) {
      modelView.getHotels();
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (modelView.state == HotelState.loading) {
      return loading();
    } else if (modelView.state == HotelState.error) {
      return const Center(
        child: Text("Error"),
      );
    }

    return Scaffold(
      drawer: Drawer(
        width: 230,
        child: ListView(
          children: [
            SwitchListTile(
              title: const Text("Dark Mode"),
              value: themeProvider.isDarkMode,
              onChanged: (value) {
                themeProvider.toggleTheme();
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout", style: TextStyle(color: Colors.red)),
              onTap: () {
                Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
              },
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: FlexibleSpaceBar(
              title: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: "Welcome, ",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    TextSpan(
                      text: displayName,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )
              )
            ),
            expandedHeight: 200,
            // pinned: true,
            actions: [
              IconButton(
                onPressed: () {}, 
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
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 210,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.only(right: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue,
                              onTap: () {
                                // Navigator.pushNamed(context, '/detail');
                              },
                              child: SizedBox(
                                width: 150,
                                height: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(modelView.hotels[index].name, style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),),
                                    ),
                                    /* Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                      child: Text(
                                        modelView.hotels[index].hotel_description,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ), */
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.location_on, size: 20, color: Colors.grey),
                                          Expanded(
                                            child: Text(
                                              modelView.hotels[index].address.toString().substring(0, 10),
                                              maxLines: 1,
                                              overflow: TextOverflow.visible,
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            )
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
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Card(
                            margin: const EdgeInsets.only(right: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              splashColor: Colors.blue[50],
                              onTap: () {},
                              child: const SizedBox(
                                width: 150,
                                height: 200,
                              )
                            )
                          );
                        },
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

  Widget loading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
  
}