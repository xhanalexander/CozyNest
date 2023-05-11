import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cozynest/screen/components/shimmerCard.dart';
import 'package:cozynest/screen/hotel/hotel_view_detail.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cozynest/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/highlight.dart';
import '../../main.dart';
import '../components/searchButton.dart';
import '../profile/profile_view.dart';
import 'hotel_viewModel.dart';

class HotelViews extends StatefulWidget {
  const HotelViews({super.key});

  @override
  State<HotelViews> createState() => _HotelViewsState();
}

class _HotelViewsState extends State<HotelViews> {
  late String displayName = "";
  late String email = "";

  @override
  void initState() {
    super.initState();
    isLogin();
    Provider.of<InnViewModel>(context, listen: false);
    Provider.of<LocalInnViewModel>(context, listen: false);
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
                isLogout(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bug_report),
              title: const Text("Report Bug"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: themeProvider.isDarkMode ? Colors.white12 : Colors.amber[600],
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
                    const ExploreButton(),
                    const RecoHighlight(highlighted: "Recomended",),
                    recomendedCards(category: "popularity"),
                    const SizedBox(height: 10),
                    const FeaturedHighlight(highlighted: "Featured",),
                    featuredCard(category: "review_score"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget recomendedCards({required String category}) {
    final innModelView = Provider.of<InnViewModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (innModelView.state == HotelState.initial) {
      innModelView.getInns(checkin : "2023-05-10", checkout : "2023-05-11", ordersBy : category);
      return const Center(child: LoadCards());
    } else if (innModelView.state == HotelState.loading) {
      return const Center(child: LoadCards());
    } else if (innModelView.state == HotelState.error) {
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
                      return HotelDetail(indexes: index, hotelName: innModelView.inns[index].hotelName, DescBy: "popularity",);
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
                      child: CachedNetworkImage(
                        imageUrl: innModelView.inns[index].max_1440PhotoUrl,
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SpinKitFadingFour(
                          color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
                          size: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        innModelView.inns[index].hotelName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined, 
                            size: 20, 
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black54
                          ),
                          Expanded(
                            child: Text(
                              innModelView.inns[index].address,
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontSize: 14,
                                color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
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

  Widget featuredCard({required String category}) {
    final innModelViewFeatured = Provider.of<LocalInnViewModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (innModelViewFeatured.state == HotelState.initial) {
      innModelViewFeatured.getExploreLocalInn(ordersBy: category);
      return const Center(child: LoadCards());
    } else if (innModelViewFeatured.state == HotelState.loading) {
      return const Center(child: LoadCards());
    } else if (innModelViewFeatured.state == HotelState.error) {
      return const Center(child: ErrorCard());
    }

    return SizedBox(
      width: double.infinity,
      height: 230,
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
                      return InnDetail(indexes: index);
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
                      child: CachedNetworkImage(
                        imageUrl: innModelViewFeatured.inns[index].max_1440PhotoUrl,
                        width: double.infinity,
                        height: 120,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => SpinKitFadingFour(
                          color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
                          size: 50,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        innModelViewFeatured.inns[index].hotelName,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.location_on_outlined, 
                            size: 20,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black54
                          ),
                          Expanded(
                            child: Text(
                              innModelViewFeatured.inns[index].address,
                              maxLines: 1,
                              overflow: TextOverflow.visible,
                              style: TextStyle(
                                fontSize: 14,
                                color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
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