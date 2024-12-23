import 'package:delivery_app/models/order_model.dart';
import 'package:delivery_app/screens/OrderDetailsScreen/order_details_controller.dart';
import 'package:delivery_app/utils/date.dart';
import 'package:delivery_app/widgets/network_carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderDetailsScreen extends StatelessWidget {
  final AppOrder order;

  final controller = Get.put(OrderDetailsController());

  OrderDetailsScreen({super.key, required this.order}) {
    controller.init(order);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order #${order.billNumber}"),
      ),
      body: Obx(
        () => ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow("Bill Amount:",
                      "Rs. ${controller.order.value?.billAmount ?? 'N/A'}"),
                  _buildDetailRow(
                      "Order Date:", LONG_DATE_FORMAT.format(order.billDate)),
                  _buildDetailRow(
                      "Order Status:", controller.order.value?.status ?? 'N/A'),
                  _buildDetailRow(
                      "Customer:", controller.customer.value?.name ?? 'N/A'),
                  _buildDetailRow(
                      "Address:", controller.customer.value?.address ?? 'N/A'),
                  _buildDetailRow(
                      "Phone:", controller.customer.value?.phone ?? 'N/A'),
                ],
              ),
            ),
            NetworkCarouselSlider(imgList: order.billImages),

            // Add action buttons (call, change status, cancel order)

            controller.nextOrderStatus.value == null
                ? const SizedBox.shrink()
                : ElevatedButton(
                    onPressed: controller.onChangeStatus,
                    child: Text("Mark as ${controller.nextOrderStatus.value}"),
                  ),

            controller.order.value?.status == OrderStatus.cancelled
                ? const SizedBox.shrink()
                : ElevatedButton(
                    onPressed: controller.onCancelOrder,
                    style:
                        ElevatedButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text("Cancel Order"),
                  ),
          ],
        ),
      ),

      // Add a floating action button to call the customer
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onCallCustomer,
        child: const Icon(Icons.call),
      ),
    );
  }
}

Widget _buildDetailRow(String title, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    ),
  );
}
