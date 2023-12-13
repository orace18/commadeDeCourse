import 'package:get/get.dart';

class Demande {
  final String title;
  final String nom;
  final String prenom;
  final DateTime dateDemande;
  final String message;

  Demande({
    required this.title,
    required this.nom,
    required this.prenom,
    required this.dateDemande,
    required this.message,
  });
}

class DemandeController extends GetxController {
  // Liste de demandes
  List<Demande> _listDemandes = [
    Demande(
      title: 'Demande de livraison urgente',
      nom: 'Dupont',
      prenom: 'Jean',
      dateDemande: DateTime(2023, 12, 15),
      message:
          'J\'ai besoin d\'une livraison rapide pour la commande en cours.',
    ),
    Demande(
      title: 'Demande de livraison urgente',
      nom: 'Dupont',
      prenom: 'Jean',
      dateDemande: DateTime(2023, 12, 15),
      message:
          'J\'ai besoin d\'une livraison rapide pour la commande en cours.',
    ),
    Demande(
      title: 'Demande de livraison urgente',
      nom: 'Dupont',
      prenom: 'Jean',
      dateDemande: DateTime(2023, 12, 15),
      message:
          'J\'ai besoin d\'une livraison rapide pour la commande en cours.',
    ),
    Demande(
      title: 'Demande de livraison urgente',
      nom: 'Dupont',
      prenom: 'Jean',
      dateDemande: DateTime(2023, 12, 15),
      message:
          'J\'ai besoin d\'une livraison rapide pour la commande en cours.',
    ),
  ];

  // Getter pour obtenir la liste des demandes
  List<Demande> get listDemandes => _listDemandes;

  // Méthode pour ajouter une nouvelle demande
  // void ajouterDemande(String nom, String prenom) {
  //   DateTime now = DateTime.now();
  //   Demande nouvelleDemande = Demande(
  //     nom: nom,
  //     prenom: prenom,
  //     dateDemande: now,
  //     message: message,
  //   );
  //   _listDemandes.add(nouvelleDemande);

  //   // Mettre à jour les observateurs
  //   update();
  // }

  // Méthode pour annuler une demande spécifique
  void annulerDemande(int index) {
    _listDemandes.removeAt(index);
    update();
  }

  // Méthode pour valider une demande spécifique
  void validerDemande(int index) {
    // Logique de validation de la demande
    // ...
    update();
  }
}
