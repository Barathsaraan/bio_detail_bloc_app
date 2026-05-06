import 'package:biodetail/bloc/profile_bloc.dart';
import 'package:biodetail/bloc/profile_state.dart';
import 'package:biodetail/pages/detailpage.dart';
import 'package:biodetail/pages/home_page.dart';
import 'package:biodetail/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainNavPage extends StatefulWidget {
  const MainNavPage({super.key});

  @override
  State<MainNavPage> createState() => _MainNavPageState();
}

class _MainNavPageState extends State<MainNavPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [HomePage(), DetailPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final profile = context.read<ProfileBloc>().currentProfile;

          return BottomNavigationBar(
            currentIndex: _currentIndex,
            selectedItemColor: Colors.indigo,
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Detail',
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.grey.shade300,
                  backgroundImage: profile.image.isNotEmpty
                      ? NetworkImage(profile.image)
                      : null,
                  child: profile.image.isEmpty
                      ? const Icon(Icons.person, size: 14)
                      : null,
                ),
                label: 'Profile',
              ),
            ],
          );
        },
      ),
    );
  }
}
