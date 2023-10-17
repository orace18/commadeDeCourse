// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:gestion_kiosque/views/login.dart';
// import 'package:gestion_kiosque/views/map.dart';
// import 'package:internet_connection_checker/internet_connection_checker.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tzData;
// import 'package:gestion_kiosque/utils/notification_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
//
// //IN LOCAL COMMENT IN PROD
// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }
// //*
// void main() async{
//   //IN LOCAL COMMENT IN PROD
//   HttpOverrides.global = new MyHttpOverrides();
//   //*
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await NotificationHelper().setup();
//
//   SystemChrome.setPreferredOrientations(
//       [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
//
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: HomePage(),
//   ));
// }
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   _HomePageState createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage>  {
//   bool _visible = true;
//   bool loading = true;
//   bool _connected = false;
//   bool _location = false;
//   var currentPosition;
//   String progressText = "Chargement des ressources...";
//   var isSupervisor;
//   var isKiosquist;
//
//   void setUserType() async {
//     var pref = await SharedPreferences.getInstance();
//     setState(() {
//       isSupervisor = (pref.getString('type') == "superviseur") ? true : false;
//       isKiosquist = (pref.getString('type') == "kiosquiste") ? true : false;
//     });
//     if (isSupervisor){
//       NotificationHelper().addSupervisorNotification(
//         'rappel_superviseur',
//         'N\'oubliez pas de soumettre le point du jour à votre coordonnateur !',
//         'Rappel journalier',
//       );
//     } else if (isKiosquist){
//       NotificationHelper().addKiosquistNotification(
//         'rappel_kiosquiste',
//         'N\'oubliez pas de soumettre votre rapport du jour !',
//         'Rappel journalier',
//       );
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     execute(InternetConnectionChecker());
//     setUserType();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//         children: [
//           Scaffold(
//               body: Container(
//                 height: MediaQuery.of(context).size.height,
//                 child:Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                       width: MediaQuery.of(context).size.width,
//                       child: Center(
//                         child: Image(
//                             image: AssetImage('assets/login_logo.png'),
//                             width: MediaQuery.of(context).size.width * 0.7
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 70,
//                     ),
//                     Container(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Icon(
//                               !_connected ? Icons.mobiledata_off : Icons.wifi,
//                               color: !_connected ? Colors.red : Colors.lightGreen,
//                               size: 30,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                     loading ? Container(
//                         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//                         child: LinearProgressIndicator(
//                           color: Color(0xFF404D9C),
//                           backgroundColor: Color(0x44404D9C),
//                         )
//                     ) : Container(
//                         padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
//                         child: LinearProgressIndicator(
//                           color: Color(0xFF404D9C),
//                           backgroundColor: Color(0x44404D9C),
//                           value: 100,
//                         )
//                     ),
//                     Container(
//                       child: Text(
//                         progressText,
//                       ),
//                     )
//                   ],
//                 ),
//               )
//           ),
//           Container(
//             alignment: Alignment.bottomCenter,
//             padding: EdgeInsets.symmetric(vertical: 20),
//             child: Text(
//               "2022©Copyright",
//               style: TextStyle(
//                   color: Color(0xFF404D9C),
//                   decoration: TextDecoration.none,
//                   fontSize: 15
//               ),
//             ),
//           )
//         ]
//     );
//   }
//
//   Future<void> execute(
//       InternetConnectionChecker internetConnectionChecker,
//       ) async {
//     final bool isConnected = await InternetConnectionChecker().hasConnection;
//     SnackBar connected = SnackBar(
//       backgroundColor: Color(0xFF404D9C),
//       content: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("Vous êtes connecté !"),
//           Icon(Icons.wifi, color: Colors.green,)
//         ],
//       ),
//       duration: Duration(seconds: 4),
//     );
//     SnackBar disconnected = SnackBar(
//       backgroundColor: Color(0xFF404D9C),
//       content: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text("Vous êtes déconnecté !"),
//           Icon(Icons.mobiledata_off, color: Colors.red,)
//         ],
//       ),
//       duration: Duration(seconds: 4),
//     );
//     // ignore: avoid_print
//     print(
//       isConnected.toString(),
//     );
//     print(
//       'Current status: ${await InternetConnectionChecker().connectionStatus}',
//     );
//     // checkConnected();
//     final StreamSubscription<InternetConnectionStatus> listener =
//     InternetConnectionChecker().onStatusChange.listen(
//           (InternetConnectionStatus status) {
//         // ScaffoldMessenger.of(context).clearSnackBars();
//         switch (status) {
//           case InternetConnectionStatus.connected:
//             ScaffoldMessenger.of(context).showSnackBar(connected);
//             setState(() {
//               _connected = true;
//             });
//             getCurrentLocation();
//             break;
//           case InternetConnectionStatus.disconnected:
//             setState(() {
//               _connected = false;
//             });
//             ScaffoldMessenger.of(context).showSnackBar(disconnected);
//             break;
//         }
//       },
//     );
//   }
//   //location
//   getLocation() async
//   {
//     Position position = await Geolocator.getCurrentPosition();
//     setState(() {
//       currentPosition = position;
//       print("position : ${position}");
//     });
//     ScaffoldMessenger.of(context).clearSnackBars();
//     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=> MapPage(currentPosition: currentPosition,)));
//   }
//
//   Future getCurrentLocation() async {
//     bool serviceEnabled;
//     LocationPermission permission;
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     print("service : ${serviceEnabled}");
//     if (!serviceEnabled) {
//       setState(() {
//         _location = false;
//       });
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
//     }
//     permission = await Geolocator.checkPermission();
//     print("permission : ${permission}");
//     if (permission == LocationPermission.denied) {
//       setState(() {
//         _location = false;
//       });
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         setState(() {
//           _location = false;
//         });
//         Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
//       }
//     }
//
//     if (permission == LocationPermission.deniedForever) {
//       // Permissions are denied forever, handle appropriately.
//       setState(() {
//         _location = false;
//       });
//       Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
//     }
//
//     await getLocation();
//
//     setState(() {
//       _location = false;
//     });
//   }
//
//
//
//   // Future<void> _scheduleDailyTenAMNotification() async {
//   //   await flutterLocalNotificationsPlugin.zonedSchedule(
//   //       0,
//   //       'Rappel',
//   //       'N\'oubliez pas de soumettre votre rapport quotidien !',
//   //       _nextInstanceOfTenAM(),
//   //       const NotificationDetails(
//   //         android: AndroidNotificationDetails('daily notification channel id',
//   //             'daily notification channel name',
//   //             channelDescription: 'daily notification description'),
//   //       ),
//   //       androidAllowWhileIdle: true,
//   //       uiLocalNotificationDateInterpretation:
//   //       UILocalNotificationDateInterpretation.absoluteTime,
//   //       matchDateTimeComponents: DateTimeComponents.time);
//   // }
//
//   tz.TZDateTime _nextInstanceOfTenAM() {
//     final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
//     tz.TZDateTime scheduledDate =
//     tz.TZDateTime(tz.local, now.year, now.month, now.day, 22);
//     if (scheduledDate.isBefore(now)) {
//       scheduledDate = scheduledDate.add(const Duration(days: 1));
//     }
//     return scheduledDate;
//   }
//
// }
