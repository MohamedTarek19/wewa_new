import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';



class VendorScreen extends StatefulWidget {
  VendorScreen({super.key});

  @override
  State<VendorScreen> createState() => _VendorScreenState();
}

class _VendorScreenState extends State<VendorScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  GoogleMapController? newGoogleMapController;
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 11.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
    bearing: 192.8334901395799,
    target: LatLng(37.43296265331129, -122.08832357078792),
    tilt: 59.440717697143555,
    zoom: 19.151926040649414,
  );
  //late Location _locationController;

  bool resetLocation = false;
  var markedPosition;
  bool serviceEnabled = false;
  late LocationData currentPosition;
  Location locationController = Location();

  Locale loc = const Locale("ar");



  _locatePosition() async {
    setState(() {
      resetLocation = true;
    });
    var p = await locationController.getLocation();
    //Position p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = p;
    });
    LatLng latlngposition = LatLng(currentPosition.latitude??0, currentPosition.longitude??0);
    CameraPosition cam = new CameraPosition(target: latlngposition, zoom: 15);
    newGoogleMapController!.animateCamera(CameraUpdate.newCameraPosition(cam));
  }

  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        initialCameraPosition: _kGooglePlex,
        zoomGesturesEnabled: true,
        zoomControlsEnabled: true,
        onTap: (val) {
          print("#########################################################3\n$val");
        },
        onMapCreated: (GoogleMapController controller) async {
          _controller.complete(controller);
          newGoogleMapController = controller;
          PermissionStatus _permissionGranted;
          serviceEnabled = await locationController.serviceEnabled();
          if (!serviceEnabled) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 5),
              backgroundColor: Colors.red,
              content: Text('Location services are disabled.'),
            ));
            serviceEnabled = await locationController.requestService();
          }
          _permissionGranted = await locationController.hasPermission();
          if (_permissionGranted == PermissionStatus.denied) {
            _permissionGranted = await locationController.requestPermission();
            if (_permissionGranted == PermissionStatus.denied) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                duration: Duration(seconds: 5),
                backgroundColor: Colors.red,
                content: Text('Location permissions are denied'),
              ));
            }
          }
          setState(() {
            _locatePosition();
          });
          locationController.onLocationChanged.listen((event) {
            if(event.latitude != null && event.longitude != null){

            }
          });

        },
        markers: {
          Marker(markerId: MarkerId('1'), icon: BitmapDescriptor.defaultMarkerWithHue(100), position: LatLng(30.025603486746856, 31.438122242689136)),
          Marker(markerId: MarkerId('2'), icon: BitmapDescriptor.defaultMarkerWithHue(100), position: LatLng(30.02723863572498, 31.44571825861931)),
        },
      ),
    );
  }
}
