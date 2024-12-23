import 'package:delivery_app/screens/OrdersScreen/order_list.dart';
import 'package:delivery_app/services/order_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({super.key});

  final orderService = Get.find<OrderService>();
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Column(children: [
          const TabBar(
            isScrollable: true,
            tabs: [
              Tab(text: "Pending"),
              Tab(text: "Out for Delivery"),
              Tab(text: "Delivered"),
              Tab(text: "Cancelled"),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: [
                Obx(() => OrderList(orders: orderService.pendingOrders)),
                Obx(() => OrderList(orders: orderService.outForDeliveryOrders)),
                Obx(() => OrderList(orders: orderService.deliveredOrders)),
                Obx(() => OrderList(orders: orderService.cancelledOrders)),
              ],
            ),
          ),
        ]));
  }
}
