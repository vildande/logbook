import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logbook/bloc/user_bloc.dart';
import 'package:logbook/pages/home_page.dart';
import 'package:logbook/utility/data_loader.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => DataLoader()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            lazy: false,
            create: (context) =>
                UserBloc(dataLoader: context.read<DataLoader>())
                  ..add(GetInProgressUsersEvent()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Bloc API',
          builder: (context, child) {
            final mediaQueryData = MediaQuery.of(context);
            return MediaQuery(
              data: mediaQueryData.copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
