 
 
 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

 import 'package:url_launcher/url_launcher.dart';
 
 
     final List<Map<String, dynamic>> moodCards = [
  {
 
 'color':
             Color.fromARGB(205, 203, 202, 202),
 
 'child':
 
 Column(
   children: [
     Padding(
       padding: const EdgeInsets.fromLTRB(20,20,10,0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Container(
             width: 60,
             height: 60,
             decoration: BoxDecoration(
               color: Color.fromARGB(255, 230, 235, 218),
               borderRadius: BorderRadius.circular(20),
             ),
             child: Center(
                 child: SvgPicture.asset(
                   'assets/Vectorm.svg',
                   width: 20,
                   height: 20,
                  // fit: BoxFit.cover,
                 ),
               ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 20),
             child: Text(
               'Listen to Your Favourite\n Music',textAlign: TextAlign.center,
               style: TextStyle(
                 fontSize: 17,
                 fontWeight: FontWeight.bold,
                 color: Colors.black,
               ),
             ),
           ),
           
         ],
       ),
     ),Padding(
       padding: const EdgeInsets.all(15),
       child: GestureDetector(onTap: ()async {
       final Uri url =  Uri.parse('https://open.spotify.com/');
        await launchUrl(url,mode: LaunchMode.inAppWebView);
       },
         child: Container(  
             width: double.infinity,
               
               height:43,
               decoration: BoxDecoration(
            color: const Color(0xFF9BB068),    
                                  borderRadius: BorderRadius.circular(30),
             
               ),child: Center(child: Text('Spotify', style: TextStyle(
                   fontSize: 15,
                   fontWeight: FontWeight.w600,
                   color: Colors.black,
                 ),)),
               
         ),
       ),
     ),
   ],
 ),},

 // second card

 {
  'color':Colors.white ,
  'child': Column(
   children: [
     Padding(
       padding: const EdgeInsets.fromLTRB(20,20,10,0),
       child: Row(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
           Container(
             width: 60,
             height: 60,
             decoration: BoxDecoration(
               color: Color.fromARGB(255, 230, 235, 218),
               borderRadius: BorderRadius.circular(20),
             ),
             child: Center(
                 child: SvgPicture.asset(
                   'assets/Vectorm.svg',
                   width: 20,
                   height: 20,
                  // fit: BoxFit.cover,
                 ),
               ),
           ),
           Padding(
             padding: const EdgeInsets.only(left: 20),
             child: Text(
               'Listen to Your \nFavourite Music',
               style: TextStyle(
                 fontSize: 19,
                 fontWeight: FontWeight.bold,
                 color: Colors.black,
               ),
             ),
           ),
           
         ],
       ),
     ),Padding(
       padding: const EdgeInsets.all(15),
       child: GestureDetector(onTap: () {
         
       },
         child: Container(  
             width: double.infinity,
               
               height:43,
               decoration: BoxDecoration(
            color: const Color(0xFF9BB068),                          borderRadius: BorderRadius.circular(30),
             
               ),child: Center(child: Text('Spotify', style: TextStyle(
                   fontSize: 15,
                   fontWeight: FontWeight.w600,
                   color: Colors.black,
                 ),)),
               
         ),
       ),
     ),
   ],)
 }
,
//3rd  card

 {
  'color':Colors.white ,
  'child': Column(mainAxisAlignment: MainAxisAlignment.center,
   children: [
     Text('Write a diary...',style: TextStyle(color: Colors.grey[600],fontWeight: FontWeight.bold),)
   ],)
 }
          ,
          ];