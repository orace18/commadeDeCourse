import 'package:get/get.dart';
import 'package:otrip/pages/passager_demande_page/models/passager_demande.dart';



class PassagerDemandeController extends GetxController {
  // Liste de demandes
  List<PassagerDemande> _listDemandes = [
    PassagerDemande(
      title: 'Demande de livraison urgente',
      nom: 'Dupont',
      prenom: 'Jean',
      dateDemande: DateTime(2023, 12, 15),
      message:
          'J\'ai besoin d\'une livraison rapide pour la commande en cours.',
    ),
    PassagerDemande(
      title: 'Demande de livraison urgente',
      nom: 'Dupont',
      prenom: 'Jean',
      dateDemande: DateTime(2023, 12, 15),
      message:
          'J\'ai besoin d\'une livraison rapide pour la commande en cours.',
    ),
    PassagerDemande(
      title: 'Demande de livraison urgente',
      nom: 'Dupont',
      prenom: 'Jean',
      dateDemande: DateTime(2023, 12, 15),
      message:
          'J\'ai besoin d\'une livraison rapide pour la commande en cours.',
    ),
    PassagerDemande(
      title: 'Demande de livraison urgente',
      nom: 'Dupont',
      prenom: 'Jean',
      dateDemande: DateTime(2023, 12, 15),
      message:
          'J\'ai besoin d\'une livraison rapide pour la commande en cours.',
    ),
  ];

  // Getter pour obtenir la liste des demandes
  List<PassagerDemande> get listDemandes => _listDemandes;

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
