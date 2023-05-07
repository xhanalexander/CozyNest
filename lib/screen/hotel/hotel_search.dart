import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cozynest/screen/hotel/hotel_viewModel.dart';
import 'package:cozynest/themes/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../components/shimmerCard.dart';
import 'hotel_view_detail.dart';

class Hotelsearch extends StatefulWidget {
  const Hotelsearch({super.key});

  @override
  State<Hotelsearch> createState() => _HotelsearchState();
}

class _HotelsearchState extends State<Hotelsearch> {
  String checkinDate = '';
  String checkoutdate = '';
  final currentDate = DateTime.now();
  final periodDate = DateTime.now().add(const Duration(days: 80));

  void showDatePickerCheckin(BuildContext context) async {
    final selectDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: periodDate,
    );
    setState(() {
      if (selectDate != null /* && selectDate != checkinDate */) {
        checkinDate = DateFormat('yyyy-MM-dd').format(selectDate);
      }
    });
  }

  void showDatePickerCheckout(BuildContext context) async {
    final pickDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: currentDate,
      lastDate: periodDate,
    );
    setState(() {
      if (pickDate != null /* && pickDate != checkoutdate */) {
        checkoutdate = DateFormat('yyyy-MM-dd').format(pickDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hotel Search',
          style: themeProvider.isDarkMode ? const TextStyle(color: Colors.amber) : const TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: themeProvider.isDarkMode ? accentColor : Colors.black54,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: accentColor,
            height: 1.0,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Check In', 
                        style: TextStyle(
                          fontSize: 16, 
                          fontWeight: FontWeight.w600,
                          color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
                        )
                      ),
                      ],
                    )
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Check Out', 
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.w600,
                            color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
                          )
                        ),
                      ],
                    )
                  ),
                ],
              ),
              const SizedBox(height: 9),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        showDatePickerCheckin(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: themeProvider.isDarkMode ? 1 : 0,
                            color: themeProvider.isDarkMode ? Colors.white : Colors.grey[300]!,
                          ),
                          color: themeProvider.isDarkMode ? Colors.transparent : Colors.grey[300]!,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(checkinDate, style: const TextStyle(color: Colors.grey)),
                            const Icon(Icons.calendar_month, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        showDatePickerCheckout(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            width: themeProvider.isDarkMode ? 1 : 0,
                            color: themeProvider.isDarkMode ? Colors.white : Colors.grey[300]!,
                          ),
                          color: themeProvider.isDarkMode ? Colors.transparent : Colors.grey[300]!,
                        ),  
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(checkoutdate, style: TextStyle(color: Colors.grey[600])),
                            const Icon(Icons.calendar_month, color: Colors.grey),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 7),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: themeProvider.isDarkMode ? Colors.amber : primaryThird,
                      ),
                      onPressed: () async {
                        await Provider.of<InnViewModel>(context, listen: false).getInns(checkin: checkinDate, checkout: checkoutdate, ordersBy: 'review_score');
                        if (checkinDate == '' || checkoutdate == '') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please insert date'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      child: const Text('Apply Date'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              innGridSearch(),
            ],
          ),
        ),
      ),
    );
  }

  Widget innGridSearch() {
    final innViewModel = Provider.of<InnViewModel>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    if (innViewModel.state == HotelState.initial) {
      innViewModel.getInns(checkin: checkinDate, checkout: checkoutdate, ordersBy: 'review_score');
      return const Center(child: Text('Insert date to search'));
    } else if (innViewModel.state == HotelState.loading) {
      return const Center(child: LoadGrid());
    } else if (innViewModel.state == HotelState.error) {
      return Padding(
        padding: const EdgeInsets.only(top: 128),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.search_off, color: Colors.grey, size: 50),
              SizedBox(height: 10),
              Text('No Result Found...', style: TextStyle(color: Colors.grey)),
            ],
          )
        ),
      );
    }

    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: min(innViewModel.inns.length, 7),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemBuilder: (context, index) {
          return AnimationConfiguration.staggeredGrid(
            position: index,
            duration: const Duration(milliseconds: 375),
            columnCount: 2,
            child: SlideAnimation(
              verticalOffset: 200.0,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, _) {
                          return HotelDetail(indexes: index, hotelName: innViewModel.inns[index].hotelName, DescBy: '',);
                        },
                        transitionsBuilder: (context, animation, _, child) {
                          return FadeTransition(
                            opacity: animation,
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CachedNetworkImage(
                          imageUrl: innViewModel.inns[index].max_1440PhotoUrl,
                          placeholder: (context, url) => SpinKitFadingFour(
                            color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
                            size: 50,
                          ),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                          fit: BoxFit.cover,
                          height: 150,
                          width: double.infinity,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          innViewModel.inns[index].hotelName,
                          style: TextStyle(
                            fontSize: 16, 
                            fontWeight: FontWeight.w600,
                            color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            Icon(
                              Icons.location_on, 
                              size: 18, 
                              color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                            ),
                            Expanded(
                              child: Text(
                                innViewModel.inns[index].address, 
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 14, 
                                  color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                                )
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        /* Text(innViewModel.inns[index].priceBreakdown.currency + ' ' + innViewModel.inns[index].priceBreakdown.grossPrice.toString()), */
                        Row(
                          children: [
                            Icon(
                              Icons.attach_money, 
                              size: 18, 
                              color: themeProvider.isDarkMode ? secondaryColor : Colors.black54),
                            Text(
                              innViewModel.inns[index].priceBreakdown.grossPrice.toString(), 
                              style: TextStyle(
                                fontSize: 14, 
                                color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}