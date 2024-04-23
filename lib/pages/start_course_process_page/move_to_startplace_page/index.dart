import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:otrip/pages/send_message_page/index.dart';
import 'package:otrip/pages/start_course_process_page/start_course_page/index.dart';
import 'package:provider/provider.dart';
import 'package:web_socket_channel/io.dart';
import '../../../api/api_constants.dart';
import '../../../constants.dart';
import '../../../providers/theme/theme.dart';

class MessageData{
  String msgtext, userid;
  bool isme;
  MessageData({ required this.msgtext, required this.userid, required this.isme});

}

class MoveToStartPlacePage extends StatefulWidget {
  String departPlace;
  String destinationPlace;
  String passagerId;
  MoveToStartPlacePage({required this.departPlace, required this.destinationPlace, required this.passagerId});

  @override
  _MoveToStartPlacePageState createState() => _MoveToStartPlacePageState();
}

class _MoveToStartPlacePageState extends State<MoveToStartPlacePage> {
  Completer<GoogleMapController> _controller = Completer();
  LatLng _initialCameraPosition = LatLng(0, 0);
  LatLng _finalAddressPosition = LatLng(6.3611985, 2.3715073); // Coordonnées géographiques par défaut
  Set<Polyline> _polylines = {};
  LocationData? _currentLocation;
  int? _estimatedTime;
  FlutterTts flutterTts = FlutterTts();
  bool _isNavigating = false;
  bool _BotomStartIsTrue = false;
  int _counter = 0;
  late Timer _timer;
  bool connected = false;
  String myid = GetStorage().read('id').toString();
  String auth = "chatapphdfgjd34534hjdfk"; //auth key
  String msgtext = "";
  String mymessage = 'Je suis la';
  late IOWebSocketChannel channel;

  List<MessageData> msglist = [];

  @override
  void initState() {
    super.initState();
    channelconnect();
    _getDepartureCoordinates();
    _getCurrentLocation();
    _startTimer();
  }

  channelconnect(){
    try{
      channel = IOWebSocketChannel.connect("ws://$chatSocketUrl/$myid");

      channel.stream.listen((message) {
        print(message);
        setState(() {
          if(message == "connected"){
            connected = true;
           // setState(() { });
            print("Connection establised.");
          }else if(message == "send:success"){
            print("Message send success");
            setState(() {
              msgtext = "";
            });
          }else if(message == "send:error"){
            print("Message send error");
          }else if (message.substring(0, 6) == "{'cmd'") {
            print("Message data");
            message = message.replaceAll(RegExp("'"), '"');
            var jsondata = json.decode(message);

            msglist.add(MessageData(
              msgtext: jsondata["msgtext"],
              userid: jsondata["userid"],
              isme: false,
            )
            );
            setState(() {

            });
          }
        });
      },
        onDone: () {
          //if WebSocket is disconnected
          print("Web socket is closed");
          setState(() {
            connected = false;
          });
        },
        onError: (error) {
          print(error.toString());
        },);
    }catch (_){
      print("error on connecting to websocket.");
    }
  }


  Future<bool> sendmsg(String sendmsg, String id) async {

    if(connected == true){
      String msg = "{'auth':'$auth','cmd':'send','userid':'$id', 'msgtext':'$sendmsg'}";
      print("le message est: $msg");
      channel.sink.add(msg); //send message to reciever channel
      msgtext = "";
      return true;
    }else{
      channelconnect();
      print("Websocket is not connected.");
      return false;
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void _amThere() {
    setState(() {

      _timer = Timer.periodic(Duration(minutes: 1), (timer) {
        setState(() {
          _counter++;
          if (_counter >= 5) {
            _BotomStartIsTrue = true;
            _timer?.cancel();
          }
        });
      });
    });
  }


  void _stopCounter() {
    setState(() {
      _counter = 0;
      _BotomStartIsTrue = true;
      _timer?.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('En route vers départ client'),
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(_currentLocation!.latitude!,
                  _currentLocation!.longitude!),
              zoom: 13.5,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              Marker(
                markerId: MarkerId('InitialPosition'),
                position: _initialCameraPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueBlue),
              ),
              Marker(
                markerId: MarkerId('FinalAddress'),
                position: _finalAddressPosition,
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
              ),
            },
            polylines: _polylines,
          ),
          _buildBottomSheet(),
        ],
      ),
    );
  }

  Widget _buildBottomSheet() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child:  GestureDetector(
        onTap: () {
          if (_isNavigating) {
            _stopNavigation();
          } else {
            _startNavigation();
          }
        },
        child: SingleChildScrollView(child: Container(
          //height: 150,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                _isNavigating
                    ? 'Arrêter la navigation'
                    : 'Commencer la navigation',
                style: TextStyle(fontSize: 18, color:  Colors.deepOrange),
              ),
              SizedBox(height: 8),
              if (_estimatedTime != null)
                Text(
                  'Temps estimé: $_estimatedTime minutes',
                  style: TextStyle(fontSize: 16),
                ),
              SizedBox(height: 8),
              ElevatedButton(
                onPressed: () async{
                  _amThere();
                  String recieverid = widget.passagerId;
                  Get.to(SendMessagePage(receiverid: recieverid));
                /*print('Je suis là');

                  bool isTrue;
                  msgtext = mymessage;
                   isTrue = await sendmsg(msgtext, recieverid);
                  if(isTrue == true) {
                    showMessageDialog(context, msgtext + ' envoyé');
                  }*/
                },
                onLongPress: (){
                  debugPrint('Je suis là');
                  _stopCounter();
                },
                style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.white,
                    textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    elevation: 0,
                    backgroundColor: AppTheme.otripMaterial,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))
                ),
                child: Text(
                  'Je suis là',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
              SizedBox(height: 8,),
              if(_BotomStartIsTrue)
              ElevatedButton(
                onPressed: () {
                  Get.to(StartCoursePage(depart: widget.departPlace, destination: widget.destinationPlace,));
                },
                style: ElevatedButton.styleFrom(
                    surfaceTintColor: Colors.white,
                    textStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                    elevation: 0,
                    backgroundColor: AppTheme.otripMaterial,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0))
                ),
                child: Text(
                  'Démarrer la course',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),)
    );
  }

  void _getCurrentLocation() async {
    LocationData? locationData;
    Location location = Location();

    try {
      locationData = await location.getLocation();
    } catch (e) {
      print("Error getting location: $e");
      return;
    }

    setState(() {
      _currentLocation = locationData;
      _initialCameraPosition = LatLng(
          locationData!.latitude!, locationData.longitude!);
      _getDirections();
    });
  }

  void _getDirections() async {
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${_currentLocation!.latitude},${_currentLocation!.longitude}&destination=${_finalAddressPosition.latitude},${_finalAddressPosition.longitude}&key=$google_api_key';
    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);
    if (data['status'] == 'OK') {
      var routes = data['routes'];
      if (routes.isNotEmpty) {
        var route = routes[0];
        var overviewPolyline = route['overview_polyline'];
        var encodedPoints = overviewPolyline['points'];
        List<LatLng> decodedPoints = _decodePoly(encodedPoints);
        setState(() {
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            color: Colors.blue,
            width: 5,
            points: decodedPoints,
          ));
          _estimatedTime = route['legs'][0]['duration']['value'] ~/ 60;
        });
      }
    }
  }

  List<LatLng> _decodePoly(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1F) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      double latDouble = lat / 1E5;
      double lngDouble = lng / 1E5;
      LatLng position = LatLng(latDouble, lngDouble);
      poly.add(position);
    }
    return poly;
  }

  void _startNavigation() async {
    String text =
        "Prenez la direction ${_currentLocation!.latitude! > _finalAddressPosition.latitude ? 'sud' : 'nord'}, " +
            "${_currentLocation!.longitude! > _finalAddressPosition.longitude ? 'ouest' : 'est'}";

    await flutterTts.speak(text);
    setState(() {
      _isNavigating = true;
    });
  }

  void _stopNavigation() async {
    await flutterTts.stop();
    setState(() {
      _isNavigating = false;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 02), (Timer timer) {
      _getCurrentLocation();
    });
  }

  void _stopTimer() {
    _timer.cancel();
  }

  void _getDepartureCoordinates() async {
    String departurePlace = widget.departPlace;
    print("Le la destination $departurePlace");
    String url = 'https://maps.googleapis.com/maps/api/geocode/json?address=$departurePlace&key=$google_api_key';

    var response = await http.get(Uri.parse(url));
    var data = json.decode(response.body);

    if (data['status'] == 'OK') {
      var results = data['results'];
      if (results.isNotEmpty) {
        var location = results[0]['geometry']['location'];
        double lat = location['lat'];
        double lng = location['lng'];

        setState(() {
          _finalAddressPosition = LatLng(lat, lng);
        });
      }
    }
  }

  void showMessageDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Message"),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }


}
