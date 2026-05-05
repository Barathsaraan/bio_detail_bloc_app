import 'package:biodetail/bloc/user_bloc.dart';
import 'package:biodetail/bloc/user_event.dart';
import 'package:biodetail/bloc/user_state.dart';
import 'package:biodetail/pages/add_form.dart';
import 'package:biodetail/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          // initstate
          if (state is UserInitState) {
            return const SizedBox.shrink();
          }

          // loading state
          if (state is UserLoadingState) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Fetching users...'),
                ],
              ),
            );
          }

          //loaded state
          if (state is UserLoadedState) {
            final users = state.users;
            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 12),
              itemCount: users.length,
              itemBuilder: (context, index) {
                return UserCard(user: users[index]);
              },
            );
          }

          // error state
          if (state is UserErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 48),
                  const SizedBox(height: 12),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<UserBloc>().add(FetchUsersEvent());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),

      // Add button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: () {
          // captures the current context read bloc before navigating
          final userBloc = context.read<UserBloc>();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: userBloc,
                child: const AddDetailPage(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
