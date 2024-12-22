class AppOrder {
  final List<String> billImages;
  final int billAmount;
  final int billNumber;
  final String customerPhone;
  final DateTime billDate;

  AppOrder({
    required this.billImages,
    required this.billAmount,
    required this.billNumber,
    required this.customerPhone,
    required this.billDate,
  });

  AppOrder.fromJson(Map<String, dynamic> json)
      : billImages = List<String>.from(json['billImages']),
        billAmount = json['billAmount'],
        billNumber = json['id'],
        customerPhone = json['customerPhone'],
        billDate = json['billDate'].toDate();

  Map<String, dynamic> toJson() => {
        'billImages': billImages,
        'billAmount': billAmount,
        'id': billNumber,
        'customerPhone': customerPhone,
        'billDate': billDate,
      };
}
