import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/* 
void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationUpdates(),
    );
  }
}

class LocationUpdates extends StatefulWidget {
  @override
  _LocationUpdatesState createState() => _LocationUpdatesState();
}

class _LocationUpdatesState extends State<LocationUpdates> {
  late final LocationService _locationService;

  @override
  void initState() {
    super.initState();
    _locationService = LocationService(
        WebSocketChannel.connect(Uri.parse('ws://$baseUrl/')));
    _checkLocationPermission();
  }

  @override
  void dispose() {
    _locationService.stopSendingPosition();
    super.dispose();
  }

  void _checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Permission Requise"),
            content: Text(
                "Voulez vous autoriser cette application à utiliser votre position ?"),
            actions: [
              ElevatedButton(
                child: Text("Non"),
                onPressed: () {
                  Navigator.of(context).pop();
                  exit(0);
                },
              ),
              ElevatedButton(
                child: Text("Oui"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _locationService.startSendingPosition();
                },
              ),
            ],
          );
        },
      );
    } else {
      await _locationService.startSendingPosition();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mise à jour de la position'),
      ),
      body: Center(
        child: Text('Envoie de la position au backend...'),
      ),
    );
  }
}
 */


class LocationService {
  final WebSocketChannel _channel;
  Stream<Position>? _positionStream;
  String userId = GetStorage().read('id').toString();

  LocationService(this._channel);

  Future<void> startSendingPosition() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    _positionStream = Geolocator.getPositionStream();
    _positionStream?.listen((Position position) {
      final Map<String, dynamic> data = {
        'userId': userId,
        'longitude': position.longitude,
        'latitude': position.latitude,
      };
      print("Donnée envoyé: $data");
      _channel.sink.add(jsonEncode(data));
    });
  }

  void dispose() {
    _channel.sink.close();
  }
}

