import 'package:otrip/api/conduteur/models/driver_list.dart';

class Demande {
  DateTime dateDemande;
  String status;
  Driver driver;

  Demande({ 
    required this.dateDemande,
    required this.status,
    required this.driver
  });

  // formatage de la donnée
  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      status:  json['status'] ?? '',
      driver: json['conducteur'] ?? '',
      dateDemande: DateTime.parse(json['created_at'] ?? ''),
    );
  }

}