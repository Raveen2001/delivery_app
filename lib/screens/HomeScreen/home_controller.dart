import 'package:delivery_app/screens/CustomerScreen/customer_screen.dart';
import 'package:delivery_app/screens/DeliveryScreen/delivery_screen.dart';
import 'package:delivery_app/screens/OrderScreen/order_screen.dart';
import 'package:delivery_app/screens/ProfileScreen/profile_screen.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;

  final screens = [
    const OrderScreen(),
    const DeliveryScreen(),
    const CustomerScreen(),
    ProfileScreen(),
  ];

  get screen => screens[selectedIndex.value];

  void onDestinationSelected(int index) {
    selectedIndex.value = index;
  }
}
