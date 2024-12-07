class AppCustomer {
  final String name;
  final String phone;
  final String address;
  final String? googleLocation;
  final DateTime createdAt;

  AppCustomer({
    required this.name,
    required this.phone,
    required this.address,
    this.googleLocation,
    required this.createdAt,
  });

  AppCustomer.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone = json['phone'],
        address = json['address'],
        googleLocation = json['googleLocation'],
        createdAt = json['createdAt'].toDate();

  Map<String, dynamic> toJson() => {
        'name': name,
        'phone': phone,
        'address': address,
        'googleLocation': googleLocation,
        'createdAt': createdAt,
      };
}
