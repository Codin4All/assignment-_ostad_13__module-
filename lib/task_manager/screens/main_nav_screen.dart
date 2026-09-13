import 'package:task_manager/task_manager/screens/cancel_task_screen.dart';
import 'package:task_manager/task_manager/screens/completed_task_screen.dart';

import 'package:task_manager/task_manager/screens/logout_screen.dart';
import 'package:task_manager/task_manager/screens/new_task_screen.dart';
import 'package:task_manager/task_manager/screens/progress_task_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/tm_appbar.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int selectedIndex = 0;

  List screens = [
    NewTaskScreen(),
    ProgressTaskScreen(),
    CompletedTaskScreen(),
    CancelTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 26, 38, 80),
              ),
              child: Text(
                'Task Manager',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),

            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                Navigator.pop(context);
                LogoutScreen.show(context);
              },
            ),
          ],
        ),
      ),
      appBar: TmAppBar(),
      body: screens[selectedIndex],

      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (int index) {
          selectedIndex = index;
          setState(() {});
        },

        destinations: [
          NavigationDestination(icon: Icon(Icons.task), label: 'New'),
          NavigationDestination(icon: Icon(Icons.refresh), label: 'Progress'),
          NavigationDestination(
            icon: Icon(Icons.task_alt_outlined),
            label: 'Completed',
          ),
          NavigationDestination(
            icon: Icon(Icons.cancel_outlined),
            label: 'Cancel',
          ),
        ],
      ),
    );
  }
}
