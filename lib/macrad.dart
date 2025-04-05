 
 
 import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

 
 
 
     final List<Map<String, dynamic>> moodCards = [
  {
 
 'color':Colors.white ,
 
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
   ],
 ),},
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
   ],)
 }
          ,
          ];