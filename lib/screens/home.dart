// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget {
  double latMap = 13.0827;
  double lngMap = 80.2707;
  HomePage(this.latMap,this.lngMap);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Completer<GoogleMapController> _controller = Completer();
 // Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  CameraPosition _currentPosition;

  @override
  initState() {
    super.initState();
    _currentPosition = CameraPosition(
      target: LatLng(widget.latMap,widget.lngMap),
      zoom: 12,
    );
  }

  _locateMe() async {
   /* _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) async {
      final GoogleMapController controller = await _controller.future;
      final _position = CameraPosition(
        target: LatLng(res.latitude, res.longitude),
        zoom: 12,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(_position));
      setState(() {
        _lat = res.latitude;
        _lng = res.longitude;
      });
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: <Widget>[
          Container(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          initialCameraPosition: _currentPosition,
          markers: {
            Marker(
              markerId: MarkerId('current'),
              position: LatLng(widget.latMap,widget.lngMap),
            )
          },
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
              IconButton(
              icon: Icon(Icons.arrow_back,color: Colors.grey,),
              onPressed: () => Navigator.of(context).pop(),
            ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
