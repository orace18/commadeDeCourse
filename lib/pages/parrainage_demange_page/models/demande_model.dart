import 'package:otrip/api/conduteur/models/driver_list.dart';

class Demande {
  int id;
  String dateDemande;
  String status;
  Driver driver;

  Demande(
      {required this.id, required this.dateDemande, required this.status, required this.driver});

  // formatage de la donnée
  factory Demande.fromJson(Map<String, dynamic> json) {
    return Demande(
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      driver: json['conducteur'] ?? '',
      dateDemande: json['created_at'] ?? '',
    );
  }
}
