class Course {
  int id;
  String departure;
  String destination;
  bool started;
  bool finished;

  Course({
    required this.id,
    required this.departure,
    required this.destination,
    this.started = false,
    this.finished = false,
  });
}
