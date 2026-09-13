import 'package:task_manager/task_manager/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/task_manager/screens/login_screen.dart';

class LogoutScreen {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Log out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },

              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                await AuthController.logout();
                Navigator.pop(dialogContext);
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),

              child: Text('Log out'),
            ),
          ],
        );
      },
    );
  }
}
