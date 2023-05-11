import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../themes/constant.dart';
import 'hotel_viewModel.dart';
import 'package:url_launcher/url_launcher.dart';

class HotelDetail extends StatefulWidget {
  final int indexes;
  final String hotelName;
  final String DescBy;
  const HotelDetail({Key? key, required this.indexes, required this.hotelName, required this.DescBy})
      : super(key: key);

  @override
  State<HotelDetail> createState() => _HotelDetailState(DescBy: DescBy,);
}

class _HotelDetailState extends State<HotelDetail> {
  final String DescBy;

  _HotelDetailState({required this.DescBy});

  final URLs = "https://api.stay.id/v1/hotel/detail?hotel_id=";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final detailInn = Provider.of<InnViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          detailInn.inns[widget.indexes].hotelName,
          style: TextStyle(
            // color: secondaryColor,
            color: themeProvider.isDarkMode ? Colors.amber : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: themeProvider.isDarkMode ? accentColor : Colors.black54,
          // color: Colors.black,
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
                child: CachedNetworkImage(
                  imageUrl: detailInn.inns[widget.indexes].max_1440PhotoUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 200,
                  placeholder: (context, url) => SpinKitFadingFour(
                    color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                detailInn.inns[widget.indexes].hotelName,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.amber : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: themeProvider.isDarkMode ? secondaryColor : Colors.black,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      detailInn.inns[widget.indexes].address,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Price : ${detailInn.inns[widget.indexes].priceBreakdown.currency}',
                        style: TextStyle(
                          fontSize: 18,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        detailInn.inns[widget.indexes].priceBreakdown.grossPrice.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Facilities",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.amber : Colors.black
                ),
              ),
              const SizedBox(height: 7),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.wifi,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Free Wifi",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Row(
                      children: [
                        Icon(
                          Icons.local_parking,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Free Parking",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Row(
                      children: [
                        Icon(
                          Icons.restaurant,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Restaurant",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Row(
                      children: [
                        Icon(
                          Icons.pool,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Swimming Pool",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.smoke_free,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "No Smoking",
                            style: TextStyle(
                              fontSize: 16,
                              color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 7),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.amber : Colors.black
                ),
              ),
              const SizedBox(height: 7),
              ExpandableText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Blandit turpis cursus in hac habitasse platea. Sed libero enim sed faucibus turpis in eu mi bibendum.",
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 2,
                animation: true,
                animationCurve: Curves.easeInCubic,
                linkColor: Colors.blue,
                style: TextStyle(
                  fontSize: 14,
                  color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: themeProvider.isDarkMode ? Colors.amber[600] : primaryThird,
                  ),
                  onPressed: () async {
                    const phoneNumber = '081318583537';
                    var message = 'Hello! I want to book a for 1 room please in ${detailInn.inns[widget.indexes].hotelName}';
                    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';
                    await canLaunch(url) ? launch(url) : print('Cannot launch $url');
                  }, 
                  child: const Text("Send Message"),
                ),
              )
            ],
          ),
        ),
      ),
    );
    
  }
}

// --------------------------------------- Hardcoded pls halp --------------------------------------- //

class InnDetail extends StatefulWidget {
  final int indexes;
  const InnDetail({super.key, required this.indexes});

  @override
  State<InnDetail> createState() => _InnDetailState();
}

class _InnDetailState extends State<InnDetail> {

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final detailInn = Provider.of<LocalInnViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          detailInn.inns[widget.indexes].hotelName,
          style: TextStyle(
            // color: secondaryColor,
            color: themeProvider.isDarkMode ? Colors.amber : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(
          color: themeProvider.isDarkMode ? accentColor : Colors.black54,
          // color: Colors.black,
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
                child: CachedNetworkImage(
                  imageUrl: detailInn.inns[widget.indexes].max_1440PhotoUrl,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  height: 200,
                  placeholder: (context, url) => SpinKitFadingFour(
                    color: themeProvider.isDarkMode ? Colors.amber[600] : Colors.black,
                    size: 50,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                detailInn.inns[widget.indexes].hotelName,
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.amber : Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: themeProvider.isDarkMode ? secondaryColor : Colors.black,
                  ),
                  const SizedBox(width: 10),
                  Flexible(
                    child: Text(
                      detailInn.inns[widget.indexes].address,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 16,
                        color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "Price : ${detailInn.inns[widget.indexes].priceBreakdown.currency}",
                        style: TextStyle(
                          fontSize: 18,
                          // fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        detailInn.inns[widget.indexes].priceBreakdown.grossPrice.toString(),
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                "Facilities",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.amber : Colors.black
                ),
              ),
              const SizedBox(height: 7),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.wifi,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Free Wifi",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Row(
                      children: [
                        Icon(
                          Icons.local_parking,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Free Parking",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Row(
                      children: [
                        Icon(
                          Icons.restaurant,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Restaurant",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Row(
                      children: [
                        Icon(
                          Icons.pool,
                          color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          "Swimming Pool",
                          style: TextStyle(
                            fontSize: 16,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    Padding(padding: const EdgeInsets.all(10)),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Icon(
                            Icons.smoke_free,
                            color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "No Smoking",
                            style: TextStyle(
                              fontSize: 16,
                              color: themeProvider.isDarkMode ? secondaryColor : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Description",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: themeProvider.isDarkMode ? Colors.amber : Colors.black
                ),
              ),
              const SizedBox(height: 7),
              ExpandableText(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Blandit turpis cursus in hac habitasse platea. Sed libero enim sed faucibus turpis in eu mi bibendum. \n\nUt sem viverra aliquet eget sit. Id semper risus in hendrerit gravida rutrum. Nibh ipsum consequat nisl vel pretium lectus quam. Elementum facilisis leo vel fringilla est ullamcorper eget nulla facilisi. \n\nLectus magna fringilla urna porttitor rhoncus dolor. Orci nulla pellentesque dignissim enim sit amet venenatis. Euismod elementum nisi quis eleifend quam adipiscing.",
                expandText: 'show more',
                collapseText: 'show less',
                maxLines: 2,
                animation: true,
                animationCurve: Curves.easeInCubic,
                linkColor: Colors.blue,
                style: TextStyle(
                  fontSize: 14,
                  color: themeProvider.isDarkMode ? secondaryColor : Colors.black54,
                ),
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    backgroundColor: themeProvider.isDarkMode ? Colors.amber[600] : primaryThird,
                  ),
                  onPressed: () async {
                    const phoneNumber = '081318583537';
                    var message = 'Hello! I want to book a for 1 room please in ${detailInn.inns[widget.indexes].hotelName}';
                    final url = 'https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}';
                    await canLaunch(url) ? launch(url) : print('Cannot launch $url'); 
                  }, 
                  child: const Text("Send Message"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}