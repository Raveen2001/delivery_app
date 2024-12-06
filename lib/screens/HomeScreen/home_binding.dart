import 'package:delivery_app/services/user_service.dart';
import 'package:get/get.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserService());
  }
}
