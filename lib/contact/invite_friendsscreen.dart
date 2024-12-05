// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';





class InviteFriendsscreen extends StatefulWidget {
  const InviteFriendsscreen({super.key});

  @override
  State<InviteFriendsscreen> createState() => _InviteFriendsscreenState();
}

class _InviteFriendsscreenState extends State<InviteFriendsscreen> {
  final List<Map<String, dynamic>> friends = [
    {
      "name": "Scarlett Johnson",
      "phone": "+300-555-0305",
      "status": "Invite",
      "image": "assets/images/service/profile.jpg"
    },
    {
      "name": "Wanda Vision",
      "phone": "+202-555-0736",
      "status": "Invite",
      "image": "assets/images/service/profile1.jpg"
    },
    {
      "name": "Tony Stark",
      "phone": "+303-555-0199",
      "status": "Invited",
      "image": "assets/images/service/profile2.jpg"
    },
  ];

  void _showShareOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Share Invitation",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildShareOption(FontAwesomeIcons.whatsapp, "WhatsApp"),
                  _buildShareOption(Icons.facebook, "Facebook"),
                  _buildShareOption(FontAwesomeIcons.twitter, "Twitter"),
                  _buildShareOption(Icons.email, "Email"),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildShareOption(IconData icon, String title) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade200,
          child: Icon(icon, color: Theme.of(context).primaryColor),
          radius: 30,
        ),
        SizedBox(height: 8),
        Text(title, style: TextStyle(fontSize: 12)),
      ],
    );
  }

  void _inviteFriend(int index) {
    setState(() {
      // Update the status to "Invited"
      friends[index]['status'] = "Invited";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              //  Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => HomePage()),
              // );
            },
            child: Icon(Icons.arrow_back_ios, color: Colors.white,)),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Invite Friends", style: TextStyle(color: Colors.white),),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: friends.length,
        itemBuilder: (context, index) {
          final friend = friends[index];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(friend['image']),
                  radius: 25,
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(friend['name'],
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(friend['phone'], style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Change the status to "Invited" when button is clicked
                    _inviteFriend(index);
                    _showShareOptions(context);
                  },
                  child: Text(
                    friend['status'],
                    style: TextStyle(
                      color: friend['status'] == "Invite"
                          ? Colors.white
                          : Theme.of(context).primaryColor,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: friend['status'] == "Invite"
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}






///import contact
///dependencies:
  // contacts_service: ^0.6.3
  // permission_handler: ^11.1.0

///<uses-permission android:name="android.permission.READ_CONTACTS"/>



// import 'package:flutter/material.dart';
// import 'package:contacts_service/contacts_service.dart';
// import 'package:permission_handler/permission_handler.dart';

// class InviteFriendsScreen extends StatefulWidget {
//   const InviteFriendsScreen({super.key});

//   @override
//   State<InviteFriendsScreen> createState() => _InviteFriendsScreenState();
// }

// class _InviteFriendsScreenState extends State<InviteFriendsScreen> {
//   List<Contact> contacts = []; // To store device contacts

//   @override
//   void initState() {
//     super.initState();
//     fetchContacts();
//   }

//   // Fetch contacts from the device
//   Future<void> fetchContacts() async {
//     if (await Permission.contacts.request().isGranted) {
//       final Iterable<Contact> fetchedContacts =
//           await ContactsService.getContacts(withThumbnails: false);
//       setState(() {
//         contacts = fetchedContacts.toList();
//       });
//     } else {
//       // Handle permission denied
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Permission to access contacts is denied.")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         leading: InkWell(
//           onTap: () {
//             Navigator.pop(context);
//           },
//           child: Icon(Icons.arrow_back_ios,_ios),
//         ),
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//         title: Text("Invite Friends"),
//       ),
//       body: contacts.isEmpty
//           ? Center(child: CircularProgressIndicator()) // Show loading until contacts are fetched
//           : ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: contacts.length,
//               itemBuilder: (context, index) {
//                 final contact = contacts[index];
//                 final phones = contact.phones?.map((e) => e.value).toList() ?? [];
//                 final phone = phones.isNotEmpty ? phones.first : "No Phone";

//                 return Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 8.0),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         child: Icon(Icons.person),
//                         radius: 25,
//                       ),
//                       SizedBox(width: 16),
//                       Expanded(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(contact.displayName ?? "No Name",
//                                 style: TextStyle(fontWeight: FontWeight.bold)),
//                             Text(phone, style: TextStyle(color: Colors.grey)),
//                           ],
//                         ),
//                       ),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Toggle invite status or perform action
//                         },
//                         child: Text(
//                           "Invite",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Theme.of(context).primaryColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//     );
//   }
// }
