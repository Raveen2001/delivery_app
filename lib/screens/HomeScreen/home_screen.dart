import 'package:delivery_app/screens/HomeScreen/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/home";

  HomeScreen({super.key});

  final controller = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: SvgPicture.asset(
        "assets/icons/horizontal-logo.svg",
      )),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: controller.onDestinationSelected,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.list_outlined),
              label: "Orders",
            ),
            NavigationDestination(
                icon: Icon(Icons.local_shipping_outlined),
                label: "Out For Delivery"),
            NavigationDestination(
              icon: Icon(Icons.group_outlined),
              label: "Customers",
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              label: "Profile",
            ),
          ],
        ),
      ),
      floatingActionButton:
          FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add)),
    );
  }
}
