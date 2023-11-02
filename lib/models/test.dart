import 'package:hive/hive.dart';

part 'test.g.dart';

@HiveType(typeId: 0)
class Test {

  @HiveField(0)
  int id;
  @HiveField(1)
  double age;
  @HiveField(2)
  String nom;
  @HiveField(3)
  bool married;
  @HiveField(4)
  List<int> listint;
  // @HiveField(5)
  // Note notes;

  Test({required this.id,required this.age,required this.nom,required this.married,required this.listint});

  factory Test.fromMap(Map<String, dynamic> map) {
    return Test(
      id: map['id'],
      age: map['age'],
      nom: map['nom'],
      married: map['married'],
      listint: map['listint'],
      // notes: map['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'age': age,
      'nom': nom,
      'married': married,
      'listint': listint,
      // 'notes': notes,
    };
  }
}
