import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

class RestaurantDetailPage extends StatelessWidget {
  final String name;
  final String location;
  final String rating;
  final String timing;
  final List<String> tags;
  final String imageUrl;

  RestaurantDetailPage({
    required this.name,
    required this.location,
    required this.rating,
    required this.timing,
    required this.tags,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // Dummy data
    List<String> foodImages = [
      'assets/images/service/food1.jpg',
      'assets/images/service/food2.jpg',
      'assets/images/service/food3.jpg',
    ];
    List<Map<String, String>> reviews = [
      {"name": "John Doe", "rating": "4.5", "comment": "Amazing food!"},
      {"name": "Jane Smith", "rating": "5.0", "comment": "Loved the ambiance."},
      {"name": "Raj Kumar", "rating": "3.5", "comment": "Decent experience."},
    ];
    List<Map<String, dynamic>> facilities = [
      {"icon": Icons.wifi, "label": "Free Wifi"},
      {"icon": Icons.local_parking, "label": "Parking"},
      {"icon": Icons.delivery_dining, "label": "Delivery Available"},
    ];

    // Map setup
    // late GoogleMapController mapController;
    // final Set<Marker> _markers = {};
    // const LatLng _restaurantLocation = LatLng(12.9716, 77.5946); // Example location
    //
    // void _onMapCreated(GoogleMapController controller) {
    //   mapController = controller;
    //   _markers.add(
    //     Marker(
    //       markerId: MarkerId('restaurant'),
    //       position: _restaurantLocation,
    //       infoWindow: InfoWindow(title: 'Restaurant Location', snippet: location),
    //     ),
    //   );
    // }

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300.0,
            pinned: true,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(name, style: TextStyle(
 fontFamily: 'Nunito',
color: Colors.white, fontWeight: FontWeight.bold)),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(imageUrl, fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Quick Info Section
                  Row(
                    children: [
                      Icon(Icons.star, color: 
Theme.of(context).primaryColor,),
                      SizedBox(width: 5),
                      Text(rating, style: TextStyle(
 fontFamily: 'Nunito',
fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 20),
                      Icon(Icons.access_time, color: Colors.grey),
                      SizedBox(width: 5),
                      Text(timing, style: TextStyle(
 fontFamily: 'Nunito',
),),
                    ],
                  ),
                  SizedBox(height: 10),
                  Wrap(
                    spacing: 8.0,
                    children: tags.map((tag) => Chip(label: Text(tag))).toList(),
                  ),
                  Divider(),
                  // Food Menu Section
                  Text("Food Menu", style: TextStyle(
 fontFamily: 'Nunito',
fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: foodImages.length,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(foodImages[index], width: 150, fit: BoxFit.cover),
                        ),
                      ),
                    ),
                  ),
                  Divider(),
                  // Facilities Section
                  Text("Facilities", style: TextStyle(
 fontFamily: 'Nunito',
fontSize: 18, fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: facilities.map((facility) {
                      return Column(
                        children: [
                          Icon(facility["icon"], color: 
Theme.of(context).primaryColor, size: 30),
                          SizedBox(height: 5),
                          Text(facility["label"], style: TextStyle(
 fontFamily: 'Nunito',
fontSize: 12)),
                        ],
                      );
                    }).toList(),
                  ),
                  Divider(),
                  // Review Section
                  Text("Reviews", style: TextStyle(
 fontFamily: 'Nunito',
fontSize: 18, fontWeight: FontWeight.bold)),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: reviews.length,
                    itemBuilder: (context, index) {
                      var review = reviews[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(review["name"]![0], style: TextStyle(
 fontFamily: 'Nunito',
),),
                        ),
                        title: Text(review["name"]!, style: TextStyle(
 fontFamily: 'Nunito',
),),
                        subtitle: Text(review["comment"]!, style: TextStyle(
 fontFamily: 'Nunito',
),),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, color: 
Theme.of(context).primaryColor, size: 18),
                            Text(review["rating"]!, style: TextStyle(
 fontFamily: 'Nunito',
),),
                          ],
                        ),
                      );
                    },
                  ),
                  Divider(),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.book,color: Colors.white),
                        label: Text("Book Now", style: TextStyle(
 fontFamily: 'Nunito',
color: Colors.white),),
                        style: ElevatedButton.styleFrom(backgroundColor: 
Theme.of(context).primaryColor,),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(Icons.phone,color: Colors.white),
                        label: Text("Call Enquiry",style: TextStyle(
 fontFamily: 'Nunito',
color: Colors.white)),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      ),
                    ],
                  ),
                  Divider(),
                  // Map Section
                  // SizedBox(
                  //   height: 200,
                  //   child: GoogleMap(
                  //     onMapCreated: _onMapCreated,
                  //     initialCameraPosition: CameraPosition(target: _restaurantLocation, zoom: 14.0),
                  //     markers: _markers,
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
