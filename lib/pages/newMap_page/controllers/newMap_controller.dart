import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class NewMapController extends GetxController {
  void navigateBack() => Get.back();

  late LocationData initialPosition;

  BitmapDescriptor userIcon = BitmapDescriptor.defaultMarker;

  RxBool isLoadingPosition = true.obs;
  RxBool isLoadingIcon = true.obs;

  @override
  void onInit() {
    getLocation();
    setUserMarker();
    super.onInit();
  }

  void setUserMarker() async {
    final Uint8List? userMarker= await getBytesFromAsset(
        path:"assets/icons/maps/user.png", //paste the custom image path
        width: 60 // size of custom image as marker
    );
    userIcon = BitmapDescriptor.fromBytes(userMarker!);
    isLoadingIcon = false.obs;
    print('icon ok');
  }

  void getLocation(){
    Location location = Location();
    location.getLocation().then((location) {
      initialPosition = location;
      isLoadingPosition = false.obs;
      print('location ok');
    });
  }

  Future<Uint8List?> getBytesFromAsset({required String path,required int width})async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(
        data.buffer.asUint8List(),
        targetWidth: width
    );
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(
        format: ui.ImageByteFormat.png))
        ?.buffer.asUint8List();
  }
}
