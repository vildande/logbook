import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logbook/bloc/user_bloc.dart';
import 'package:logbook/models/user_model.dart';
import 'package:logbook/utility/data_loader.dart';
import 'add_incub_page.dart';
import 'log_table.dart';
import '../components/incub_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(31, 38, 51, 1),
      body: BlocProvider(
        create: (context) =>
            UserBloc(dataLoader: DataLoader())..add(GetInProgressUsersEvent()),
        child: HomePageContent(),
      ),
    );
  }
}

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserLoadedState) {
          var users = state.users;
          return Stack(
            children: [
              Column(
                children: [
                  const SizedBox(height: 20),
                  // Top
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          'assets/ssh.png',
                          height: 60,
                          width: 60,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 31, 38, 51),
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: const BorderSide(color: Colors.white),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const DataTablePage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Incubation history',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Welcome text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 10, left: 20),
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
                  const SizedBox(height: 10),
                  // Today's Incubations header
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Today's Incubations",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Lower part
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 10, left: 10, right: 10, bottom: 55),
                        child: ListView.separated(
                          itemCount: users.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemBuilder: (context, index) {
                            var user = users[index];
                            return IncubCard(
                              user: user,
                              isExpanded: false,
                              onNavigate: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DataTablePage(
                                        initialRecordName: user.name),
                                  ),
                                );
                              },
                            );
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () async {
                      bool? result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AddIncubPage()),
                      );

                      if (result == true) {
                        // Trigger refresh if a new record was added
                        context.read<UserBloc>().add(GetInProgressUsersEvent());
                      }
                    },
                    child: const Text(
                      'Start Incubation',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else if (state is UserEmptyState) {
          return const Center(child: Text("No users available."));
        } else if (state is UserLoadingFailedState) {
          return Center(
              child: Text("Error loading users: ${state.errorMessage}"));
        } else {
          return const Center(child: Text("Unknown state"));
        }
      },
    );
  }
}
