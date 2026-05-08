import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_event.dart';
import 'user_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    final currentState = context.read<ProfileBloc>().state;
    debugPrint('HomePage initState — current state: $currentState');

    if (currentState is! ProfileLoadedState &&
        currentState is! ProfileUpdatedState) {
      debugPrint('HomePage initState — fetching...');
      context.read<ProfileBloc>().add(FetchProfileEvent());
    } else {
      debugPrint('no api call');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),

      // BlocListener — snackbar
      body: BlocListener<ProfileBloc, ProfileState>(
        listener: (context, state) {
          debugPrint('BlocListener: state → $state');

          if (state is ProfileLoadedState) {
            debugPrint(' BlocListener: Loaded — ${state.profile.name}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Hi, ${state.profile.name}!'),
                backgroundColor: Colors.indigo,
                duration: const Duration(seconds: 2),
              ),
            );
          }

          if (state is ProfileUpdatedState) {
            debugPrint(' BlocListener: Updated — ${state.profile.name}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Profile updated: ${state.profile.name}'),
                backgroundColor: Colors.green,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },

        //  BlocBuilder — UI only
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            debugPrint(' BlocBuilder: rebuilding — $state');

            if (state is ProfileInitState || state is ProfileLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }

            final profile = context.read<ProfileBloc>().currentProfile;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundColor: Colors.grey.shade200,
                            backgroundImage: profile.image.isNotEmpty
                                ? NetworkImage(profile.image)
                                : null,
                            child: profile.image.isEmpty
                                ? const Icon(Icons.person, size: 35)
                                : null,
                          ),
                          const SizedBox(width: 16),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi, ${profile.name}',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                profile.email,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
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
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
