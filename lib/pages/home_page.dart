import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import 'user_list_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider(
                  create: (_) => UserBloc()..add(FetchUsersEvent()),
                  child: const UserListPage(),
                ),
              ),
            );
          },
          child: const Text(
            'Click Here',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
