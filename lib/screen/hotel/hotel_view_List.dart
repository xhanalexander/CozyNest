import 'package:cozynest/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:provider/provider.dart';
import '../components/shimmerCard.dart';
import 'hotel_viewModel.dart';
import 'hotel_view_detail.dart';

class HotelList extends StatefulWidget {
  const HotelList({super.key});

  @override
  State<HotelList> createState() => _HotelListState();
}

class _HotelListState extends State<HotelList> {

  @override
  void initState() {
    super.initState();
    // Provider.of<HotelViewModel>(context, listen: false).getHotels();
    Provider.of<InnViewModel>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final modelViewList = Provider.of<InnViewModel>(context);
    if (modelViewList.state == HotelState.initial) {
      modelViewList.getInns( 
        checkin: "2023-05-10", 
        checkout: "2023-05-11", 
        ordersBy: "popularity", 
      );
      return const Center(child: Scaffold(
        body: LoadList(),
      ));
    } else if (modelViewList.state == HotelState.loading) {
      return const Center(child: Scaffold(
        body: LoadList(),
      ));
    } else if (modelViewList.state == HotelState.error) {
      return FailedData();
    }

    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: modelViewList.inns.take(10).length,
          // itemCount: 10, 
          itemBuilder: (context, index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 800),
              child: SlideAnimation(
                horizontalOffset: -300.0,
                delay: Duration(milliseconds: 235),
                child: Card(
                  // color: primarySecond,
                  child: ListTile(
                    title: Text(modelViewList.inns[index].hotelName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text(modelViewList.inns[index].address, style: const TextStyle(fontSize: 14),),
                    /* title: Text('Hotel Name', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    subtitle: Text('Hotel Address', style: TextStyle(fontSize: 14),), */
                    onTap: () {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          pageBuilder: (context, animation, _) {
                            return HotelDetail(
                              indexes: index,
                              hotelName: modelViewList.inns[index].hotelName,
                              DescBy: "popularity",
                            );
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}