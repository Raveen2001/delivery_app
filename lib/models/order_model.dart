class OrderStatus {
  static const pending = 'Pending';
  static const cancelled = 'Cancelled';
  static const outForDelivery = 'Out for delivery';
  static const delivered = 'Delivered';
}

String? getNextOrderStatus(AppOrder order) {
  switch (order.status) {
    case OrderStatus.pending:
      return OrderStatus.outForDelivery;
    case OrderStatus.outForDelivery:
      return OrderStatus.delivered;
    default:
      return null;
  }
}

class AppOrder {
  final List<String> billImages;
  final int billAmount;
  final int billNumber;
  final String customerPhone;
  final String customerName;
  final String customerAddress;
  final DateTime billDate;
  String status;

  AppOrder({
    required this.billImages,
    required this.billAmount,
    required this.billNumber,
    required this.customerPhone,
    required this.billDate,
    required this.customerName,
    required this.customerAddress,
    required this.status,
  });

  AppOrder.fromJson(Map<String, dynamic> json)
      : billImages = List<String>.from(json['billImages']),
        billAmount = json['billAmount'],
        billNumber = json['id'],
        customerPhone = json['customerPhone'],
        customerName = json['customerName'],
        customerAddress = json['customerAddress'],
        status = json['status'],
        billDate = json['billDate'].toDate();

  Map<String, dynamic> toJson() => {
        'billImages': billImages,
        'billAmount': billAmount,
        'id': billNumber,
        'customerPhone': customerPhone,
        'billDate': billDate,
        'customerName': customerName,
        'customerAddress': customerAddress,
        'status': status,
      };
}
