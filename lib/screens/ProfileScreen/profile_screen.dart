import 'package:delivery_app/services/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  final userService = Get.find<UserService>();
  ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        CircleAvatar(
          radius: 50,
          backgroundImage: NetworkImage(userService.user!.image),
        ),
        const SizedBox(height: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              userService.user!.name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              direction: Axis.horizontal,
              spacing: 10,
              children: [
                ...userService.user!.roles.map((role) => Chip(
                      label: Text(role),
                      // backgroundColor: Colors.green.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ))
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.email),
                const SizedBox(width: 10),
                Text(userService.user!.email),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.phone),
                const SizedBox(width: 10),
                Text(userService.user!.phone),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 10),
                Text(userService.user!.address),
              ],
            ),
            const SizedBox(height: 100),
            TextButton.icon(
              onPressed: () {
                Get.toNamed('/login');
              },
              style: TextButton.styleFrom(
                // backgroundColor: Colors.red.shade100,
                textStyle: const TextStyle(color: Colors.black),
              ),
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              label: const Text("Logout",
                  style: TextStyle(fontSize: 16, color: Colors.red)),
            ),
          ],
        ),
      ],
    );
  }
}
