class Driver {
  late int id;
  late String lastname;
  late String firstname;
  late String phoneNumber;
  late Map<String, dynamic> localisation;

  Driver(
      {
      required this.id,
      required this.lastname,
      required this.firstname,
      required this.phoneNumber,
      required this.localisation});

  @override
  String toString() {
    return 'Driver{id: $id, firstname: $firstname, lastname: $lastname, phoneNumber: $phoneNumber, localisation: $localisation}';
  }

    factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['name'],
      lastname: json['lastname'],
      firstname: json['name'],
      localisation: json['positions'],
      phoneNumber: json['mobile_number'],
    );
  }
}
