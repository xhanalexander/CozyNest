import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../themes/constant.dart';
import 'hotel_viewModel.dart';

class HotelDetail extends StatefulWidget {
  // const HotelDetail({super.key});
  final int indexes;
  const HotelDetail({super.key, required this.indexes});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {

  @override
  void initState() {
    super.initState();
    Provider.of<HotelViewModel>(context, listen: false).getHotels();
  }

  @override
  Widget build(BuildContext context) {
    final detailHotel = Provider.of<HotelViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          // detailHotel.hotels[widget.indexes].name,
          "Hotel Details",
          style: TextStyle(
            // color: secondaryColor,
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          // color: accentColor,
          color: Colors.black12
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: accentColor,
            height: 1.0,
          ),
        ),
      ),
      
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/img_1.jpg",
                  width: double.infinity,
                  height: 256,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                detailHotel.hotels[widget.indexes].name,
                style: const TextStyle(
                  // color: secondaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                detailHotel.hotels[widget.indexes].address!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        detailHotel.hotels[widget.indexes].exact_class.toString(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 7),
              ExpandableText(
                detailHotel.hotels[widget.indexes].hotel_description,
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 2,
                linkColor: Colors.blue,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(180, 0, 0, 0)
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    
                  }, 
                  child: const Text("Book Now"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}