import 'package:batch_18/task_manager/controller/auth_controller.dart';
import 'package:batch_18/task_manager/screens/update_profile_screen.dart';
import 'package:flutter/material.dart';

class TmAppBar extends StatelessWidget implements PreferredSize {
  const TmAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      backgroundColor: const Color.fromARGB(255, 19, 15, 27),
      title: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateProfileScreen()),
          );
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUy-t00mImJn20OoJQGOZ-hpNBUnrKty6pmaC96C6r_Q&s=10',
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${AuthController.userData?.firstName} ${AuthController.userData?.lastName}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: Colors.white),
                ),
                Text(
                  '${AuthController.userData?.email}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleSmall!.copyWith(color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
