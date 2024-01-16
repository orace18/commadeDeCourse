class Driver {
  late int id;
  late String lastname;
  late String firstname;
  late String phoneNumber;
  late Map<String, dynamic> localisation;

  Driver({
    required this.id,
    required this.lastname,
    required this.firstname,
    required this.phoneNumber,
    required this.localisation,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'] ?? 0, // Valeur par défaut si 'id' est null
      lastname:
          json['lastname'] ?? '', // Valeur par défaut si 'lastname' est null
      firstname:
          json['name'] ?? '', // Valeur par défaut si 'firstname' est null
      localisation:
          json['positions'] ?? {}, // Valeur par défaut si 'positions' est null
      phoneNumber: json['mobile_number'] ??
          '', // Valeur par défaut si 'mobile_number' est null
    );
  }
}
