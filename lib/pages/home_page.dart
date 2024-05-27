import 'dart:math';

import 'package:flutter/material.dart';
import 'package:logbook/components/incub_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 31, 38, 51),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //top
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.cabin, color: Colors.white, size: 30,),
                Icon(Icons.menu, color: Colors.white, size: 30,)
              ]
            ,)
          ),

          //welcome text
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container( padding: EdgeInsets.only(top: 15, bottom: 40, left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                    Text(
                      'Logbook',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // lower part
          Expanded(
            child: Container(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 10),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(255, 255, 255, 1),
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Incubator Usage",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                        )
                      ),
                      
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                        child: ListView.separated(
                          itemCount: 3,
                          itemBuilder: (context, index) => IncubCard(),
                          separatorBuilder: (context, index) => Padding(padding: EdgeInsets.only(bottom: 20)),
                        ),
                        width: double.infinity,
                        height: 400,
                      )
                    ],
                  ),
                ),
                ElevatedButton(
                  style:  ButtonStyle (
                    backgroundColor: MaterialStatePropertyAll<Color>(Color.fromARGB(255, 31, 38, 51)),
                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 60)),
                  ),
                  onPressed: (){},
                  
                  child: Text('Log', style: TextStyle(color: Colors.white),),
                  )
              ],),
          )
          )
        ],
      )
    );
  }
}