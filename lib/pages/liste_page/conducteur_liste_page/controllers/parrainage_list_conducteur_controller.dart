import 'package:get/get.dart';

class Person {
  final String firstName;
  final String lastName;
  final String phoneNumber;

  Person({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
  });
}

class ListConducteurController extends GetxController {
  RxList<Person> people = [
    Person(firstName: 'John', lastName: 'Doe', phoneNumber: '123456789'),
    Person(firstName: 'Alice', lastName: 'Smith', phoneNumber: '987654321'),
    Person(firstName: 'Bob', lastName: 'Johnson', phoneNumber: '456123789'),
    Person(firstName: 'Eva', lastName: 'Williams', phoneNumber: '789456123'),
    Person(firstName: 'David', lastName: 'Brown', phoneNumber: '321654987'),
    Person(firstName: 'Roger', lastName: 'Billy', phoneNumber: '54567889'),
  ].obs;
}
