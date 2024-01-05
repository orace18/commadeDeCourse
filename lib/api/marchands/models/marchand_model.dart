class Marchand{
  late int? id;
  late String? firstname;
  late String? lastname;
  late String? phoneNumber;

  Marchand({required this.id, this.firstname, required this.lastname, required this.phoneNumber});

  @override
  String toString() {
    return 'Marchand{firstname: $firstname, lastname: $lastname, phoneNumber: $phoneNumber}';
  }

  factory Marchand.fromJson(Map<String, dynamic> json) {
    return Marchand(
      id: json['id'],
      firstname: json['name'],
      lastname: json['lastname'],
      phoneNumber: json['mobile_number'],
    );
  }
}