import 'package:flutter/material.dart';

import 'property_list screen.dart';





class SubCategoryscreen extends StatefulWidget {
  const SubCategoryscreen({super.key});

  @override
  State<SubCategoryscreen> createState() => _SubCategoryscreenState();
}

class _SubCategoryscreenState extends State<SubCategoryscreen> {final List<Map<String, String>> subCategories = [
    {'icon': '🩺', 'name': 'General Physicians'},
    {'icon': '🦷', 'name': 'Dentists'},
    {'icon': '👶', 'name': 'Pediatricians'},
    {'icon': '❤️', 'name': 'Cardiologists'},
    {'icon': '🌟', 'name': 'Dermatologists'},
    {'icon': '👩‍⚕️', 'name': 'Gynecologists'},
    {'icon': '🦴', 'name': 'Orthopedists'},
    {'icon': '🧠', 'name': 'Psychiatrists'},
    {'icon': '👂', 'name': 'ENT Specialists'},
    {'icon': '👁️', 'name': 'Ophthalmologists'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      appBar: AppBar(
       backgroundColor: Theme.of(context).primaryColor,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
          
          child: Icon(Icons.arrow_back_ios,color: Colors.white,)),
        title: Text('Doctors', style: TextStyle(fontFamily: 'Nunito',color: Colors.white),),
        centerTitle: true,
        actions: [
          Icon(Icons.notifications, color: Colors.white,),
          SizedBox(width: 10,)
        ],
      ),
      body: ListView.separated(
        itemCount: subCategories.length,
        itemBuilder: (context, index) {
          final subCategory = subCategories[index];
          return ListTile(
            leading: Text(
              subCategory['icon']!,
              style: TextStyle(fontFamily: 'Nunito',fontSize: 24),
            ),
            title: Text(subCategory['name']!, style: TextStyle(fontFamily: 'Nunito',),),
            trailing: Icon(Icons.arrow_forward_ios, color: Color.fromARGB(255, 214, 212, 212),),
            onTap: () {
              // Navigate to detailed view or perform an action
              print('Tapped on ${subCategory['name']}');
              Navigator.push(
                      context,
                      MaterialPageRoute(
          builder: (context) => PropertyListingScreen()
          
          
          //  ListingScreen(

          //     name: subCategory['name']!, 
          // )
          
          
          )); 
            },
          );
        },
        separatorBuilder: (context, index) =>Padding(
        padding: const EdgeInsets.only(left: 56.0), // Add a left margin of 16 pixels
        child: Divider(
          color: const Color.fromARGB(255, 214, 212, 212), // Customize the divider color
          thickness: 0.6,       // Set the thickness of the divider
        ),
      )
      ),
    );
  }
}