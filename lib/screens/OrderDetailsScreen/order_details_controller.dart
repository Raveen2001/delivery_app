import 'package:delivery_app/models/customer_model.dart';
import 'package:delivery_app/models/order_model.dart';
import 'package:delivery_app/services/customer_service.dart';
import 'package:delivery_app/services/order_service.dart';
import 'package:delivery_app/utils/launch.dart';
import 'package:get/get.dart';

class OrderDetailsController extends GetxController {
  Rxn<AppOrder> order = Rxn<AppOrder>();
  Rxn<AppCustomer> customer = Rxn<AppCustomer>();

  final orderService = Get.find<OrderService>();
  final customerService = Get.find<CustomerService>();

  RxnString nextOrderStatus = RxnString();

  void init(AppOrder initOrder) {
    order.value = initOrder;
    customer.value =
        customerService.findCustomerByPhone(order.value!.customerPhone);
    nextOrderStatus.value = getNextOrderStatus(initOrder);
  }

  void onChangeStatus() {
    order.update((val) {
      val!.status = nextOrderStatus.value!;
    });

    nextOrderStatus.value = getNextOrderStatus(order.value!);

    // Update order status in Firestore
    orderService.updateOrder(order.value!);
  }

  Future<void> onCancelOrder() async {
    order.update((val) {
      val!.status = OrderStatus.cancelled;
    });

    await orderService.updateOrder(order.value!);
  }

  Future<void> onCallCustomer() async {
    if (customer.value != null) {
      // Call customer
      callPhoneNumber(customer.value!.phone);
    }
  }
}
