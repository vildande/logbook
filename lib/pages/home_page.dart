import 'package:flutter/material.dart';
import 'package:logbook/components/incub_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(31, 38, 51, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: 20),
          // Top
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.cabin,
                  color: Colors.white,
                  size: 30,
                ),
                Icon(
                  Icons.menu,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
          // Welcome text
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15, bottom: 40, left: 20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome to ',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      'Logbook',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Lower part
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Incubator Usage",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          width: double.infinity,
                          height: 400,
                          child: ListView.separated(
                            itemCount: 3,
                            itemBuilder: (context, index) => IncubCard(
                              name: "John Doe",
                              startTime: "13:05",
                              endTime: "19:30",
                              incubatorType: "Top Incubator",
                              isActive: index ==
                                  0, // Example condition for active state
                            ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 31, 38, 51),
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Log',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
