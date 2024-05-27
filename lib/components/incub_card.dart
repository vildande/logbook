import 'package:flutter/material.dart';

class IncubCard extends StatelessWidget {
  const IncubCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 0.5),
        borderRadius: BorderRadius.circular(10)
      ),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("John Doe"),
              Row(
                children: [
                  Icon(Icons.timer, size: 12),
                  Container(padding: EdgeInsets.only(left: 3)), // emptyspace
                  Text("13:05", style: TextStyle(fontSize: 10)),
                  Text(" - ", style: TextStyle(fontSize: 10),),
                  Text("19:30", style: TextStyle(fontSize: 10),)
                ]
              ),
            ] 
          ),
          Container(
            padding: EdgeInsets.only(top: 10),
            child: Text("Top Incubator", style: TextStyle(fontSize: 10),),
          )
          

        ],
      )
    );
  }
}