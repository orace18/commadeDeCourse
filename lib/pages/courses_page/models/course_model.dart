import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Course {
  final int id;
  late String etat;
  late String heureDepart;
  late String heureFin;
  late String placeDepart;
  late String placeArrivee;

  Course(
    {
      required this.id, 
      required this.etat, 
      required this.placeArrivee, 
      required this.heureDepart, 
      required this.placeDepart, 
      required this.heureFin
    }
  );
}
