import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logbook/models/user_model.dart';
import '../utility/data_loader.dart';
import '../bloc/user_bloc.dart';
import '../components/data_table_widget.dart';

class DataTablePage extends StatefulWidget {
  final String? initialRecordName;

  const DataTablePage({super.key, this.initialRecordName});

  @override
  _DataTablePageState createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  List<User> _filteredUsers = [];
  String _searchQuery = '';
  final int logsPerPage = 10;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  void _filterUsers(List<User> users) {
    setState(() {
      _filteredUsers = users.where((user) {
        return user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.usageDetails
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            user.incubatorType
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            user.startTime.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (user.endTime?.toLowerCase() ?? 'active')
                .contains(_searchQuery.toLowerCase()) ||
            user.comment.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            user.status.toLowerCase().contains(_searchQuery.toLowerCase());
      }).toList();
    });
  }

  void _goToPreviousPage() {
    setState(() {
      if (_currentPage > 0) {
        _currentPage--;
      }
    });
  }

  void _goToNextPage() {
    setState(() {
      if (_currentPage < (_filteredUsers.length / logsPerPage).ceil() - 1) {
        _currentPage++;
      }
    });
  }

  void _goToPage(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(31, 38, 51, 1),
      appBar: AppBar(
        title: const Text("Data Table"),
        backgroundColor: const Color.fromRGBO(31, 38, 51, 1),
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoadedState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _filterUsers(state.users);
            });

            int pageCount = (_filteredUsers.length / logsPerPage).ceil();

            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Search...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (query) {
                      setState(() {
                        _searchQuery = query;
                        _filterUsers(state.users);
                        _currentPage = 0; // Reset to first page on search
                      });
                    },
                  ),
                ),
                Expanded(
                  child: DataTableWidget(
                    users: _filteredUsers,
                    logsPerPage: logsPerPage,
                    pageIndex: _currentPage,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: _goToPreviousPage,
                        child: const Text('Previous'),
                      ),
                      Row(
                        children: List.generate(pageCount, (index) {
                          return GestureDetector(
                            onTap: () => _goToPage(index),
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              padding: const EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? Colors.blue
                                    : Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }),
                      ),
                      ElevatedButton(
                        onPressed: _goToNextPage,
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is UserEmptyState) {
            return const Center(
                child: Text(
              "No users available.",
              style: const TextStyle(color: Colors.white),
            ));
          } else if (state is UserLoadingFailedState) {
            return Center(
                child: Text(
              "Error loading users: ${state.errorMessage}",
              style: const TextStyle(color: Colors.white),
            ));
          } else {
            return const Center(child: Text("Unknown state"));
          }
        },
      ),
    );
  }
}
