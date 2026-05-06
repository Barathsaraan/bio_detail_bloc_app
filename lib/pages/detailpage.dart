import 'package:biodetail/bloc/profile_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/profile_bloc.dart';
import '../bloc/profile_state.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    final currentState = context.read<ProfileBloc>().state;
    debugPrint('DetailPage initState — current state: $currentState');

    if (currentState is! ProfileLoadedState &&
        currentState is! ProfileUpdatedState) {
      debugPrint('DetailPage: State not loaded — fetching...');
      context.read<ProfileBloc>().add(FetchProfileEvent());
    } else {
      debugPrint('no API call');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detail'), centerTitle: true),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          // Loading or Init
          if (state is ProfileInitState || state is ProfileLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          final profile = context.read<ProfileBloc>().currentProfile;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Profile Details',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        // Safe image — empty ஆ இருந்தா crash ஆகாது
                        CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.grey.shade200,
                          backgroundImage: profile.image.isNotEmpty
                              ? NetworkImage(profile.image)
                              : null,
                          child: profile.image.isEmpty
                              ? const Icon(Icons.person, size: 40)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Profile update பண்ணினா automatically இங்க மாறும்
                            Text(
                              profile.name.isNotEmpty
                                  ? profile.name
                                  : 'No name',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              profile.email.isNotEmpty
                                  ? profile.email
                                  : 'No email',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
