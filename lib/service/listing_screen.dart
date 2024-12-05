import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'detail_screen.dart';


class ListingScreen extends StatefulWidget {
  final String name;
  const ListingScreen({super.key, required this.name});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  late TextEditingController _controller; 
  bool _isEditing = false;
   String? selectedFilter;

 @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
      text: '${widget.name}\nPeria Kadai Street - George Ro...',
    ); // Combine name and address as initial text
  }
  @override
  void dispose() {
    // Dispose the controller to avoid memory leaks
    _controller.dispose();
    super.dispose();
  }

  final List<String> quickFilters = ['Top Rated', 'Popular', 'Nearby', 'Open Now'];
  final List<String> sortOptions = ['Relevance', 'Rating', 'Popular', 'Distance'];
  final List<String> insuranceAccepted = [
    'Future Generali India Insurance',
    'HDFC ERGO General Insurance',
    'Star Health & Allied Insurance'
  ];
  final List<String> ratings = ['Any', '3.5+', '4.0+', '4.5+', '5.0'];
void showAppointmentBottomSheet(BuildContext context) {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  String selectedDisease = "Select Disease";

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    builder: (context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Book an Appointment',
                      style: TextStyle( fontFamily: 'Nunito',fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 16),
                    // Name Field
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Phone Number Field
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      maxLength: 10, // Limit to 10 digits
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // Remove non-numeric characters if entered
                        if (!RegExp(r'^\d*$').hasMatch(value)) {
                          phoneController.text = value.replaceAll(RegExp(r'\D'), '');
                          phoneController.selection = TextSelection.fromPosition(
                            TextPosition(offset: phoneController.text.length),
                          );
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    // Date Picker Field
                    TextField(
                      controller: dateController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: 'Select Date',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          setState(() {
                            dateController.text =
                                '${pickedDate.toLocal()}'.split(' ')[0];
                          });
                        }
                      },
                    ),
                    SizedBox(height: 16),
                    // Disease Dropdown
                    DropdownButtonFormField<String>(
                      value: selectedDisease,
                      items: [
                        "Select Disease",
                        "Liver",
                        "Heart",
                        "Wound",
                        "Fever",
                        "Diabetes",
                      ]
                          .map((disease) => DropdownMenuItem(
                                value: disease,
                                child: Text(disease, style: TextStyle( fontFamily: 'Nunito',color: Colors.black),),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedDisease = value!;
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Disease',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 24),
                    // Submit Button
                   Center(
  child: ElevatedButton(
     style: ElevatedButton.styleFrom(
             backgroundColor: Theme.of(context).primaryColor,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),),
    onPressed: () {
      // Validation
      if (nameController.text.trim().isEmpty) {
        showError(context, 'Name cannot be empty');
        return;
      }
      if (phoneController.text.trim().length != 10) {
        showError(context, 'Phone number must be exactly 10 digits');
        return;
      }
      if (dateController.text.trim().isEmpty) {
        showError(context, 'Please select a date');
        return;
      }
      if (selectedDisease == "Select Disease") {
        showError(context, 'Please select a disease');
        return;
      }

      // Success: Form is valid, print details and proceed
      print('Name: ${nameController.text}');
      print('Phone: ${phoneController.text}');
      print('Date: ${dateController.text}');
      print('Disease: $selectedDisease');

      // Optionally submit data or perform actions here
      // Close bottom sheet only if everything is valid
      Navigator.pop(context); 
    },
    child: Text(
      'Submit',
      style: TextStyle( fontFamily: 'Nunito',color: Colors.white),
    ),
  ),


                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}

// Show error as SnackBar
void showError(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Theme.of(context).primaryColor,
    ),
  );
}




void showFilterBottomSheet(BuildContext context) {
  // State for selected quick filters
  List<String> selectedQuickFilters = [];
  // State for selected sort options (now supports multiple selections)
  Set<String> selectedSortOptions = {};
  // State for selected insurance options
  Map<String, bool> selectedInsurance = {
    for (var insurance in insuranceAccepted) insurance: false,
  };
  // State for selected ratings (now supports multiple selections)
  Set<String> selectedRatings = {};

  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
    ),
    isScrollControlled: true, // Allow the sheet to expand based on content
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setModalState) {
          return FractionallySizedBox(
            alignment: Alignment.bottomCenter,
            heightFactor: 0.7, // Set height to 70% of the screen
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      "Filter by Category",
                      style: TextStyle(
                         fontFamily: 'Nunito',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Divider(),
                    // Quick Filters Section
                    Text(
                      "Quick Filters",
                      style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Wrap(
                      spacing: 8,
                      children: quickFilters.map((filter) {
                        final isSelected = selectedQuickFilters.contains(filter);
                        return ChoiceChip(
                          label: Text(
                            filter,
                            style: TextStyle(
                               fontFamily: 'Nunito',
                              fontSize: 12,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setModalState(() {
                              if (selected) {
                                selectedQuickFilters.add(filter);
                              } else {
                                selectedQuickFilters.remove(filter);
                              }
                            });
                          },
                          selectedColor: Theme.of(context).primaryColor,
                        );
                      }).toList(),
                    ),
                    Divider(),
                    // Sort By Section
                    Text(
                      "Sort by",
                      style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Wrap(
                      spacing: 8,
                      children: sortOptions.map((option) {
                        final isSelected = selectedSortOptions.contains(option);
                        return FilterChip(
                          label: Text(
                            option,
                            style: TextStyle( fontFamily: 'Nunito',fontSize: 12),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setModalState(() {
                              if (selected) {
                                selectedSortOptions.add(option);
                              } else {
                                selectedSortOptions.remove(option);
                              }
                            });
                          },
                          selectedColor: Theme.of(context).primaryColor,
                        );
                      }).toList(),
                    ),
                    Divider(),
                    // Insurance Accepted Section
                    Text(
                      "Insurance Accepted",
                      style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: insuranceAccepted.map((insurance) {
                        return CheckboxListTile(
                          title: Text(
                            insurance,
                            style: TextStyle( fontFamily: 'Nunito',fontSize: 12),
                          ),
                          value: selectedInsurance[insurance],
                          onChanged: (bool? value) {
                            setModalState(() {
                              selectedInsurance[insurance] = value ?? false;
                            });
                          },
                        );
                      }).toList(),
                    ),
                    Divider(),
                    // Ratings Section
                    Text(
                      "Ratings",
                      style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    Wrap(
                      spacing: 8,
                      children: ratings.map((rating) {
                        final isSelected = selectedRatings.contains(rating);
                        return FilterChip(
                          label: Text(
                            rating,
                            style: TextStyle( fontFamily: 'Nunito',fontSize: 12),
                          ),
                          selected: isSelected,
                          onSelected: (selected) {
                            setModalState(() {
                              if (selected) {
                                selectedRatings.add(rating);
                              } else {
                                selectedRatings.remove(rating);
                              }
                            });
                          },
                          selectedColor: Theme.of(context).primaryColor,
                        );
                      }).toList(),
                    ),
                    Divider(),
                    // Apply Filters Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context); // Close the bottom sheet
                        // You can access selected filters here:
                        print("Selected Quick Filters: $selectedQuickFilters");
                        print("Selected Sort Options: $selectedSortOptions");
                        print("Selected Insurance: $selectedInsurance");
                        print("Selected Ratings: $selectedRatings");
                      },
                      child: Text("Apply Filters"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
       backgroundColor: Colors.white,
        leading: InkWell(
onTap: (){
  Navigator.pop(context);
},


          child: Icon(Icons.arrow_back_ios, color: Theme.of(context).primaryColor,)),
        title: _isEditing
            ? TextField(
                controller: _controller, // Use controller to manage text
                maxLines: null, // Allow multiple lines for editing
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  suffixIcon: Icon(Icons.mic, color: Colors.grey),
                  border: InputBorder.none, // Clean border
                  fillColor: Colors.white,
                     contentPadding: const EdgeInsets.all(10),
                    enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 245, 241, 235),
                        width: 1.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 241, 213, 204),
                        width: 1),
                  ),
                ),
                style: TextStyle(
                   fontFamily: 'Nunito',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                
                onEditingComplete: () {
                  // Restore to placeholder if left empty
                  setState(() {
                    _isEditing = false;
                    if (_controller.text.isEmpty) {
                      _controller.text =
                          '${widget.name}\nPeria Kadai Street - George Ro...';
                    }
                  });
                },
              )
            : GestureDetector(
                onTap: () {
                  // Enter editing mode on tap
                  setState(() {
                    _isEditing = true;
                    _controller.clear(); // Clear content for editing
                  });
                },
                child: RichText(
                  text: TextSpan(
                    text: widget.name, // Doctor's name
                    style: TextStyle(
                       fontFamily: 'Nunito',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: '\nPeria Kadai Street - George Ro...', // Address
                        style: TextStyle(
                           fontFamily: 'Nunito',
                          fontSize: 12,
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        actions: [
          Icon(Icons.share, color: Theme.of(context).primaryColor,),
          SizedBox(width: 10,)
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              // Filter & Book Appointment Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
 showFilterBottomSheet(context); 

                    },
                    icon: Icon(Icons.filter_list, color: Colors.black),
                    label: Text(
                      "Sort by",
                      style: TextStyle( fontFamily: 'Nunito',color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[200],
                      elevation: 0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {

showAppointmentBottomSheet(context);
                    },
                    child: Text(
                      "Book Appointment",
                      style: TextStyle( fontFamily: 'Nunito',color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),

              // Search Results Count
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "25 Results for your search",
                  style: TextStyle( fontFamily: 'Nunito',fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              SizedBox(height: 16),

              // Hospital Card 1
              buildHospitalCard(
                context,
                "Nisha Siddha Hospital",
                "assets/images/service/hospital1.jpg",
                "4.3",
                "64 Ratings",
                "9th Middle Street Bryant...",
                "31 Years in Healthcare",
                "Good service. I had an excellent experience at Nisha Siddha Hospital.",
                "120 Enquiries",
              ),

              // Divider
              Divider(color: Colors.grey.shade300),

              // Hospital Card 2
              buildHospitalCard(
                context,
                "Sri Lakshmi Sai Dhanvantri",
                "assets/images/service/hospital1.jpg",
                "4.9",
                "78 Ratings",
                "West Millerpuram...",
                "9 Years in Healthcare",
                "Clean & hygienic",
                "54 Enquiries",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildHospitalCard(
    BuildContext context,
    String name,
    String imagePath,
    String rating,
    String ratingCount,
    String address,
    String experience,
    String review,
    String enquiries,
  ) {
    return InkWell(

      onTap: (){
         Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen())); 
      },
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hospital Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      imagePath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8),
          
                  // Hospital Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hospital Name and Badges
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                name,
                                style: TextStyle(
                                   fontFamily: 'Nunito',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.orange.shade100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                "Top Rated",
                                style: TextStyle(
                                   fontFamily: 'Nunito',
                                  fontSize: 10,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 4),
          
                        // Rating and Address
                        Row(
                          children: [
                            Container(
                               decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Row(
                                children: [
                                  Icon(Icons.star, color: Colors.white, size: 16),
                                   Text(
                                " $rating",
                                style: TextStyle( fontFamily: 'Nunito',color: Colors.white),
                                                        ),
                                ],
                                                        ),
                              )),
                           
                            SizedBox(width: 4),
                            Text(ratingCount),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          address,
                          style: TextStyle( fontFamily: 'Nunito',color: Colors.grey, fontSize: 12),
                        ),
                        SizedBox(height: 4),
          
                        // Experience and Review
                        Text(
                          experience,
                          style: TextStyle( fontFamily: 'Nunito',fontSize: 12),
                        ),
                        SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.format_quote, size: 16, color: Colors.red),
                            SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                review,
                                style: TextStyle( fontFamily: 'Nunito',fontSize: 12),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
          
              // Actions (Call Now, Send Enquiry, WhatsApp)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildActionButton(Icons.phone, "Call", Colors.blue),
                  buildActionButton(Icons.message, "Enquiry", Colors.orange),
                  buildActionButton(FontAwesomeIcons.whatsapp, "WhatsApp", Colors.green),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildActionButton(IconData icon, String label, Color color) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: color),
      label: Text(label, style: TextStyle( fontFamily: 'Nunito',color: color)),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 3),
      ),
    );
  }
}

