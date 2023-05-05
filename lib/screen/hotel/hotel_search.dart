import 'package:cozynest/screen/hotel/hotel_viewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/shimmerCard.dart';

class Hotelsearch extends StatefulWidget {
  const Hotelsearch({super.key});

  @override
  State<Hotelsearch> createState() => _HotelsearchState();
}

class _HotelsearchState extends State<Hotelsearch> {
  String checkindate = '';
  String checkoutdate = '';

  void showDatePickerCheckin(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        checkindate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  void showDatePickerCheckout(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 90)),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        checkoutdate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Provider.of<InnViewModel>(context, listen: false).getInns(checkin: '2023-05-04', checkout: '2023-05-07');
    Provider.of<InnViewModel>(context, listen: false).getInns();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hotel Search'),
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
                      children: const [
                        Text('Check In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                      ],
                    )
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text('Check Out', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
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
                          color: Colors.grey[300],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(DateFormat('yyyy-MM-dd').format(DateTime.now())),
                            const Icon(Icons.calendar_month),
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
                          color: Colors.grey[300],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(checkoutdate),
                            const Icon(Icons.calendar_month),
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
                      ),
                      onPressed: () {
                        // Provider.of<InnViewModel>(context, listen: false).getInns(checkin: checkindate, checkout: checkoutdate);
                      },
                      child: const Text('Apply Date'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              InnGridSearch(),
            ],
          ),
        ),
      ),
    );
  }

  Widget InnGridSearch() {
    final innViewModel = Provider.of<InnViewModel>(context);
    if (innViewModel.state == HotelState.initial) {
      innViewModel.getInns();
      return const Center(child: LoadCards());
    } else if (innViewModel.state == HotelState.loading) {
      return const Center(child: CircularProgressIndicator());
    } else if (innViewModel.state == HotelState.error) {
      return const Center(child: ErrorCard());
    }
    return AnimationLimiter(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 7,
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
              verticalOffset: 50.0,
              child: Card(
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
                            image: const DecorationImage(
                              image: AssetImage('assets/images/img_1.jpg'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text('name'),
                        const SizedBox(height: 5),
                        Text('address'),
                        const SizedBox(height: 5),
                        Text('pricess'),
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