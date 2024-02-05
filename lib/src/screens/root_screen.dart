import 'package:flutter/material.dart';
import 'package:wik/src/screens/new_post_screen.dart';
import 'package:wik/src/widgets/intro_list.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WIK'),
        actions: [
          const IconButton(
            icon: Icon(Icons.search),
            onPressed: null,
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            tooltip: 'Show Snackbar',
            onPressed: () {
              Navigator.pushNamed(context, '/setting');
            },
          )
        ],
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if (index == 1) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const NewPostScreen()));
          } else {
            setState(() {
              currentPageIndex = index;
            });
          }
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.diversity_3),
            label: 'Community',
          ),
          NavigationDestination(
            icon: Icon(Icons.create),
            label: 'Create',
          ),
          NavigationDestination(
            icon: Icon(Icons.stairs),
            label: 'Rank',
          ),
        ],
      ),
      body: [
        const IntroList(),
        const SizedBox(),
        const SizedBox(),
      ][currentPageIndex],
    );
  }
}
