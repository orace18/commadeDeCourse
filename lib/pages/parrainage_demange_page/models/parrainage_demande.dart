class DemandeParrainage {
  final int id;
  final String marchandId;
  final String conducteurId;
  String conducteurNom;
  String conducteurPrenom;
  final DateTime dateDemande;

  DemandeParrainage({
    required this.id,
    required this.marchandId,
    required this.conducteurId,
    required this.dateDemande,
    this.conducteurNom = '',
    this.conducteurPrenom = '',
  });

  factory DemandeParrainage.fromJson(Map<String, dynamic> json) {
    return DemandeParrainage(
      id: json['id'] ?? 0,
      marchandId: json['marchand_id'] ?? '',
      conducteurId: json['conducteur_id'] ?? '',
      dateDemande: DateTime.parse(json['created_at'] ?? ''),
    );
  }
}
