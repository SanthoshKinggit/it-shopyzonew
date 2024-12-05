import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io'; // for File

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final List<String> uploadedPhotos = []; // Store uploaded image paths
  final List<Map<String, String>> reviews = [
    {
      'name': 'John Doe',
      'review': 'Excellent service and friendly staff.',
      'rating': '4.5'
    },
    {'name': 'Jane Smith', 'review': 'Clean and hygienic!', 'rating': '5.0'},
  ];
  final List<String> services = [
    'General Consultation',
    'Ayurvedic Treatment',
    'Pediatrics',
    'Cardiology',
    'Orthopedics',
    'Psychiatry',
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        uploadedPhotos.add(image.path);
      });
    }
  }

  Future<void> _captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        uploadedPhotos.add(image.path);
      });
    }
  }

  void _showUploadOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Upload from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _pickImage();
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take a Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _captureImage();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Nisha Siddha Hospital',
          style: TextStyle( fontFamily: 'Nunito',color: Theme.of(context).primaryColor, fontSize: 18),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Icon(Icons.search, color: Theme.of(context).primaryColor,),
          SizedBox(width: 10),
          Icon(Icons.share, color: Theme.of(context).primaryColor,),
          SizedBox(width: 10),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header Section
            Container(
              padding: const EdgeInsets.all(16.0),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Rating
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nisha Siddha Hospital',
                              style: TextStyle(
                                 fontFamily: 'Nunito',
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    '4.3 ★',
                                    style: TextStyle(
                                       fontFamily: 'Nunito',
                                        color: Colors.white, fontSize: 12),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text('64 Ratings', style: TextStyle( fontFamily: 'Nunito',),),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Image.asset(
                        'assets/images/service/hospital1.jpg', // Replace with hospital image URL
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bryant Nagar, Thoothukudi - 3.2 km',
                    style: TextStyle( fontFamily: 'Nunito',fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '31 Years in Healthcare',
                    style: TextStyle( fontFamily: 'Nunito',fontSize: 12, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildActionButton('Call', Icons.phone, Colors.blue),
                      _buildActionButton(
                          'WhatsApp', FontAwesomeIcons.whatsapp, Colors.green),
                      _buildActionButton('Direction', Icons.directions,
                          Colors.deepOrangeAccent),
                      _buildActionButton('Review', Icons.star, Colors.amber),
                    ],
                  ),
                ],
              ),
            ),

            // Tabs Section
            TabBarSection(uploadedPhotos: uploadedPhotos, showUploadOptions: _showUploadOptions, reviews: reviews, services: services),
         
           Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Address Section
                  Text(
                    'Overview',
                    style: TextStyle( fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Address',
                    style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '11 A, 9th Middle Street, Bryant Nagar, Thoothukudi - 628008 (Near Rasi Kalyanam Mandapam)',
                    style: TextStyle( fontFamily: 'Nunito',fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      _buildActionButton('Direction', Icons.location_on,
                          Colors.deepOrangeAccent),
                      SizedBox(width: 10),
                      _buildActionButton('Copy', Icons.copy, Colors.grey),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Quick Information Section
                  Text(
                    'Quick Information',
                    style: TextStyle( fontFamily: 'Nunito',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 8),
                  Text('Contacts: 0432-211005', style: TextStyle( fontFamily: 'Nunito',),),
                  Text('Year of Establishment: 1983', style: TextStyle( fontFamily: 'Nunito',),),
                  Text('Website: + Add Website', style: TextStyle( fontFamily: 'Nunito',),),
                ],
              ),
            ),
         
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildBottomButton('Call', Colors.blue),
            SizedBox(width:5),
            _buildBottomButton('Enquire', Colors.orange),
               SizedBox(width:5),
            _buildBottomButton('WhatsApp', Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String text, IconData icon, Color color) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle( fontFamily: 'Nunito',fontSize: 12, color: Colors.black),
        ),
      ],
    );
  }

Widget _buildBottomButton(String text, Color color) {
  return Expanded(
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(vertical: 16), // Ensure consistent height
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: () {
        // Perform button actions
      },
      child: Text(
        text,
        style: TextStyle(fontFamily: 'Nunito', color: Colors.white),
      ),
    ),
  );
}

}

class TabBarSection extends StatelessWidget {
  final List<String> uploadedPhotos;
  final Function showUploadOptions;
  final List<Map<String, String>> reviews;
  final List<String> services;

  TabBarSection({required this.uploadedPhotos, required this.showUploadOptions, required this.reviews, required this.services});

  @override
Widget build(BuildContext context) {
  return DefaultTabController(
    length: 3,
    child: Column(
      children: [
     TabBar(
  labelColor: Theme.of(context).primaryColor,
  unselectedLabelColor: Colors.grey,
  indicatorSize: TabBarIndicatorSize.label, // Indicator matches the tab's label
  indicator: UnderlineTabIndicator(
    borderSide: BorderSide(
      width: 2.0,
      color: Theme.of(context).primaryColor,
    ),
    insets: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width / 4), // Dynamically set for 3 equal parts
  ),
  tabs: [
    Tab(text: 'Overview'),
    Tab(text: 'Reviews'),
    Tab(text: 'Services'),
  ],
),

        Container(
          height: 300, // Height for the TabBarView
          child: TabBarView(
            children: [
              // Overview Tab
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Photos',
                        style: TextStyle( fontFamily: 'Nunito',
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                        onPressed: () => showUploadOptions(),
                        child: Text(
                          'Upload Photos',
                          style:
                              TextStyle( fontFamily: 'Nunito',color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  uploadedPhotos.isNotEmpty
                      ? GridView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                          itemCount: uploadedPhotos.length,
                          itemBuilder: (context, index) {
                            return Image.file(
                              File(uploadedPhotos[index]),
                              fit: BoxFit.cover,
                            );
                          },
                        )
                      : Align(
                        alignment: Alignment.center,
                        child: Text(
                            'No photos uploaded yet.',
                            style: TextStyle( fontFamily: 'Nunito',color: Colors.grey),
                          ),
                      ),
                ],
              ),

              // Reviews Tab
              ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  final review = reviews[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepOrange.withOpacity(0.1),
                      child: Text(
                        review['name']![0],
                        style: TextStyle( fontFamily: 'Nunito',color: Colors.deepOrange),
                      ),
                    ),
                    title: Text(review['name']!, style: TextStyle( fontFamily: 'Nunito',),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(review['review']!, style: TextStyle( fontFamily: 'Nunito',),),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text(review['rating']!, style: TextStyle( fontFamily: 'Nunito',),),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),

              // Services Tab
              ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.medical_services,
                        color: Theme.of(context).primaryColor),
                    title: Text(services[index], style: TextStyle( fontFamily: 'Nunito',),),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
}
