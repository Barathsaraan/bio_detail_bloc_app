import 'package:biodetail/pages/main_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/profile_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // ProfileBloc — app-wide share ஆகுது (Home, Detail, Profile எல்லாத்துக்கும்)
        BlocProvider(create: (_) => ProfileBloc()),
      ],
      child: MaterialApp(
        title: 'BLoC User App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const MainNavPage(),
      ),
    );
  }
}
