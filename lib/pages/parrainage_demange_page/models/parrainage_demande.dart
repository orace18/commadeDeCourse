class DemandeParrainage {
  String conducteurPhone;
  String conducteurNom;
  String status;
  String conducteurPrenom;
  final DateTime dateDemande;

  DemandeParrainage({
    required this.conducteurPhone,
    required this.dateDemande,
    required this.conducteurNom,
    required this.conducteurPrenom ,
    required this.status,
  });

  factory DemandeParrainage.fromJson(Map<String, dynamic> json) {
    return DemandeParrainage(
      status:  json['status'] ?? '',
      conducteurPhone: json['mobile_number'] ?? '',
      conducteurNom: json['lastname'] ?? '',
      conducteurPrenom: json['name'] ?? '',
      dateDemande: DateTime.parse(json['created_at'] ?? ''),
    );
  }
}
