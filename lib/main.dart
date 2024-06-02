import 'package:flutter/material.dart';
import 'package:logbook/pages/add_incub_page.dart';
import 'package:logbook/pages/home_page.dart';
import 'package:logbook/pages/log_table.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => HomePage(),
          '/add-incubation': (context) => AddIncubPage(),
          '/log-table': (context) => DataTablePage()
        });
  }
}
