import 'package:delivery_app/screens/CustomerScreen/customer_screen.dart';
import 'package:delivery_app/screens/HomeScreen/models.dart';
import 'package:delivery_app/screens/OrdersScreen/orders_screen.dart';
import 'package:delivery_app/screens/ProfileScreen/profile_screen.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var selectedIndex = 0.obs;
  final showFloatingActionButton = true.obs;

  final screens = [
    OrderScreen(),
    CustomerScreen(),
    ProfileScreen(),
  ];

  get screen => screens[selectedIndex.value];

  void onDestinationSelected(int index) {
    selectedIndex.value = index;

    showFloatingActionButton.value =
        [Screens.ORDER, Screens.CUSTOMER].contains(index);
  }

  void onAddClicked() {
    if (selectedIndex.value == Screens.ORDER) {
      Get.toNamed("/add-edit-order");
    }

    if (selectedIndex.value == Screens.CUSTOMER) {
      Get.toNamed("/add-edit-customer");
    }
  }
}
