class AppUser {
  final String id;
  final String name;
  final String phone;
  final String address;
  final String email;
  final String image;
  final List<String> roles;

  AppUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.roles,
    required this.address,
    required this.email,
    required this.image,
  });

  AppUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        phone = json['phone'],
        address = json['address'],
        email = json['email'],
        image = json['image'],
        roles = List<String>.from(json['roles']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'address': address,
        'email': email,
        'image': image,
        'roles': roles,
      };
}
