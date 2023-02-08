
class Users {
  String? address;
  String commercialID;
  String email;
  String name;
  String? phoneNumber;
  int? seatingCapacity;
  dynamic status;

  Users({
    required this.name,
    required this.email,
    this.address,
    required this.commercialID,
    this.phoneNumber,
    this.seatingCapacity = 0,
    this.status
  });
}