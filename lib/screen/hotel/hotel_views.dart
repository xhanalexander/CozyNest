import 'dart:developer';

import 'package:cozynest/screen/components/shimmerCard.dart';
import 'package:cozynest/screen/hotel/hotel_view_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cozynest/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../components/highlight.dart';
import '../../main.dart';
import '../components/searchButton.dart';
import '../profile/profile_view.dart';
import 'hotel_search.dart';
import 'hotel_viewModel.dart';
import 'hotel_view_List.dart';

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
    Provider.of<InnViewModel>(context, listen: false).getInns();
  }

  void isLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = (prefs.getString('username') ?? '');
    });
  }

  Future<void> isLogout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Navigator.pushNamedAndRemoveUntil(
      context,
      '/',
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final innModels = Provider.of<InnViewModel>(context);

    return Scaffold(
      /* bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ), */
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
                isLogout(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report),
              title: const Text("Report Bug"),
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, _) {
                      return const ProfileAccount();
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
                        fontSize: 18,
                        // color: accentColor,
                      ),
                    ),
                    TextSpan(
                      text: displayName,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        // color: secondaryColor,
                      ),
                    ),
                  ],
                )
              )
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
            expandedHeight: 200,
            pinned: true,
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, _) {
                        return const ProfileAccount();
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
                    /* Text(
                      innModels.inns.length.toString(),
                    ), */
                    const SearchButton(),
                    const Highlight(highlighted: "Recomended",),
                    // RecomendedCards(),
                    const SizedBox(height: 10),
                    const Highlight(highlighted: "Featured",),
                    FeaturedCard(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget RecomendedCards() {
    final modelView = Provider.of<HotelViewModel>(context);
    if (modelView.state == HotelState.initial) {
      modelView.getHotels();
      return const Center(child: LoadCards());
    } else if (modelView.state == HotelState.loading) {
      return const Center(child: LoadCards());
    } else if (modelView.state == HotelState.error) {
      return const Center(child: ErrorCard());
    }

    return SizedBox(
      width: double.infinity,
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            // color: primarySecond,
            margin: const EdgeInsets.only(right: 10),
            shape: const RoundedRectangleBorder(
              borderRadius: radiusBorder,
            ),
            child: InkWell(
              // splashColor: accentColor,
              onTap: () {
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, _) {
                      return HotelDetail(indexes: index);
                    },
                    transitionsBuilder: (context, animation, _, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                        begin: const Offset(1, 0),
                        end: Offset.zero,
                      ).animate(animation), child: child,);
                    },
                  ),
                );
              },
              child: SizedBox(
                width: 150,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/images/img_1.jpg",
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(modelView.hotels[index].name, style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        // color: secondaryColor,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_outlined, size: 20),
                          Expanded(
                            child: Text(
                              modelView.hotels[index].address.toString().substring(0, 10),
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontSize: 14,
                                // color: secondaryColor,
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
    );
  }

  Widget FeaturedCard() {
    final innModelView = Provider.of<InnViewModel>(context);
    return SizedBox(
      width: double.infinity,
      height: 210,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            // color: primarySecond,
            margin: const EdgeInsets.only(right: 10),
            shape: const RoundedRectangleBorder(
              borderRadius: radiusBorder,
            ),
            child: InkWell(
              // splashColor: accentColor,
              onTap: () {},
              child: SizedBox(
                width: 150,
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        "assets/images/img_1.jpg",
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                      )
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Hotel Name", style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        // color: secondaryColor,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(Icons.location_on_outlined, size: 20),
                          Expanded(
                            child: Text(
                              "Hotel Address",
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: const TextStyle(
                                fontSize: 14,
                                // color: secondaryColor,
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
    );
  }
}