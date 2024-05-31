import 'package:flutter/material.dart';
import '../utility/data_loader.dart';
import '../components/data_table_widget.dart';
import '../components/search_widget.dart';

class DataTablePage extends StatefulWidget {
  const DataTablePage({super.key});

  @override
  _DataTablePageState createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  late Future<List<UsageWithUser>> _usagesWithUser;
  List<UsageWithUser> _filteredUsagesWithUser = [];
  String _searchQuery = '';
  final int logsPerPage = 10;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _usagesWithUser = DataLoader().loadUsagesWithUser();
  }

  void _filterUsages(List<UsageWithUser> usages) {
    setState(() {
      _filteredUsagesWithUser = usages.where((usage) {
        return usage.user.name
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            usage.usage.usageDetails
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            usage.usage.incubatorType
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            usage.usage.startTime
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            (usage.usage.endTime?.toLowerCase() ?? 'active')
                .contains(_searchQuery.toLowerCase()) ||
            usage.usage.comment
                .toLowerCase()
                .contains(_searchQuery.toLowerCase()) ||
            usage.usage.status
                .toLowerCase()
                .contains(_searchQuery.toLowerCase());
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
      if (_currentPage <
          (_filteredUsagesWithUser.length / logsPerPage).ceil() - 1) {
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
      body: FutureBuilder<List<UsageWithUser>>(
        future: _usagesWithUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else {
            var usagesWithUser = snapshot.data!;
            if (_filteredUsagesWithUser.isEmpty && _searchQuery.isEmpty) {
              _filteredUsagesWithUser = usagesWithUser;
            }

            int pageCount =
                (_filteredUsagesWithUser.length / logsPerPage).ceil();

            return Column(
              children: [
                SearchWidget(onSearch: (query) {
                  setState(() {
                    _searchQuery = query;
                    _filterUsages(usagesWithUser);
                    _currentPage = 0; // Reset to first page on search
                  });
                }),
                Expanded(
                  child: DataTableWidget(
                    usagesWithUser: _filteredUsagesWithUser,
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
          }
        },
      ),
    );
  }
}
