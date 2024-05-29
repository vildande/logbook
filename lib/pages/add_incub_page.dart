import 'package:flutter/material.dart';

class AddIncubPage extends StatefulWidget {
  const AddIncubPage({super.key});

  @override
  State<AddIncubPage> createState() => _AddIncubPageState();
}

class _AddIncubPageState extends State<AddIncubPage> {

  bool _topIncubUsed = false;
  bool _bottomIncubUsed = false;

  final _contactController = TextEditingController();
  final _usageController = TextEditingController();

  void _topIncubCheck (bool? value) {
    setState(() {
          _topIncubUsed = !_topIncubUsed;
    });
  }

  void _bottomIncubCheck (bool? value) {
    setState(() {
          _bottomIncubUsed = !_bottomIncubUsed;
    });
  }

  void _startIncubPressed() {
    // log all the info from the page
    print("\n----------Add Incubation Record----------\nContact: ${_contactController.text}\nTop Incubator used: $_topIncubUsed\nBottom Incubator used: $_topIncubUsed\nUsage: ${_usageController.text}\n-----------------------------------------\n");
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: const Color.fromRGBO(31, 38, 51, 1),
            body: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                      
                          // top part
                          Container(
                            // color: Colors.red,
                            padding: const EdgeInsets.only(left: 18, right: 20, bottom: 20),
                            child: const Row(
                              children: [
                                Icon(Icons.keyboard_arrow_left, color: Colors.white, size: 40),
                                SizedBox(width: 20),
                                Text("Add Incubation Record", style: TextStyle(color: Colors.white, fontSize: 30),)
                              ],
                            ),
                          ),
                      
                          //contact info
                          Container(
                            // color: Colors.blue,
                            padding: const EdgeInsets.only(top:50, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Contact info", style: TextStyle(color: Colors.white, fontSize: 24)),
                                const Text("(First name and Last name / phone number)", style: TextStyle(color: Colors.white70, fontSize: 14),),
                                const SizedBox(height: 10),

                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: TextFormField(
                                    controller: _contactController,
                                    decoration: const InputDecoration(hintText: "Contact Info", border: InputBorder.none),
                                  )
                                ),
                                
                              ]
                            ),
                          ),
                          
                      
                          //choosing incubator type
                          Container(
                            // color: Colors.green,
                            padding: const EdgeInsets.only(top:20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Which Incubator(s)?", style: TextStyle(color: Colors.white, fontSize: 24),),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Checkbox(value: _topIncubUsed, onChanged: _topIncubCheck),
                                      const Text("Top", style: TextStyle(color: Colors.white, fontSize: 18))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    children: [
                                      Checkbox(value: _bottomIncubUsed, onChanged: _bottomIncubCheck),
                                      const Text("Bottom", style: TextStyle(color: Colors.white, fontSize: 18))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                      
                          //usage description
                          Container(
                            // color: Colors.amber,
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Usage Description", style: TextStyle(color: Colors.white, fontSize: 24)),
                                const Text("(quantity and type of tubes / content / temperature / rpm)", style: TextStyle(color: Colors.white70, fontSize: 14),),
                                const SizedBox(height: 10,),
                                Container(
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)
                                  ),
                                  child: TextFormField(
                                    controller: _usageController,
                                    decoration: const InputDecoration(hintText: 'Usage description', border: InputBorder.none),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 5,
                                  ),
                                ),
                              ],
                            ),
                          )                
                        ],
                    ),
                  ),
              
                  //start incubation button
                  ElevatedButton(
                    onPressed: _startIncubPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 20)
                    ),
                    child: const Text(
                      "Start Incubation", 
                      style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)
                    ) 
                  )
                ],
              ),
            )
    );
  }


}