import 'package:flutter/material.dart';
import 'package:logbook/pages/add_incub_page.dart';
import 'package:logbook/pages/log_table.dart';
import '../components/incub_card.dart';
import '../utility/data_loader.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<UsageWithUser>> _usagesWithUser;

  @override
  void initState() {
    super.initState();
    _usagesWithUser = DataLoader().loadUsagesWithUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(31, 38, 51, 1),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              // Top
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.cabin,
                      color: Colors.white,
                      size: 30,
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white, size: 30), 
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DataTablePage()));
                      }
                    ),
                  ],
                ),
              ),
              // Welcome text
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.only(top: 15, bottom: 40, left: 20),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to ',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                        Text(
                          'Logbook',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              // Lower part
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: FutureBuilder<List<UsageWithUser>>(
                      future: _usagesWithUser,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return const Center(
                              child: Text('Error loading data'));
                        } else {
                          var usagesWithUser = snapshot.data!;
                          return ListView.separated(
                            itemCount: usagesWithUser.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 20),
                            itemBuilder: (context, index) {
                              var usageWithUser = usagesWithUser[index];
                              return IncubCard(
                                name: usageWithUser.user.name,
                                startTime: usageWithUser.usage.startTime,
                                endTime: usageWithUser.usage.endTime,
                                incubatorType:
                                    "${usageWithUser.usage.incubatorType} Incubator",
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 31, 38, 51),
                  padding: const EdgeInsets.symmetric(horizontal: 60),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddIncubPage()));
                },
                child: const Text(
                  'Start Incubation',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
