class AppOrder {
  final List<String> billImages;
  final int billAmount;
  final int billNumber;
  final String customerId;
  final DateTime billDate;

  AppOrder({
    required this.billImages,
    required this.billAmount,
    required this.billNumber,
    required this.customerId,
    required this.billDate,
  });

  AppOrder.fromJson(Map<String, dynamic> json)
      : billImages = List<String>.from(json['billImages']),
        billAmount = json['billAmount'],
        billNumber = json['id'],
        customerId = json['customerId'],
        billDate = json['billDate'].toDate();

  Map<String, dynamic> toJson() => {
        'billImages': billImages,
        'billAmount': billAmount,
        'id': billNumber,
        'customerId': customerId,
        'billDate': billDate,
      };
}
