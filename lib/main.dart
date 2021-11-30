import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:map4/places.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Google Maps Demo',
      home: MapSample(),
    );
  }
}

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Completer<GoogleMapController> _controller = Completer();
  TextEditingController searchController = TextEditingController( );

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(11.262778165300672, 75.76712065978806),
    zoom: 13.4746,
  );
  static final Marker samp = Marker(
    markerId:MarkerId('_kGooglePlex'),
    infoWindow: InfoWindow(title: 'beach'),
    icon: BitmapDescriptor.defaultMarker,
    position: LatLng(11.262778165300672, 75.76712065978806 ),
      

  );
  static final Marker amp = Marker(
    markerId:MarkerId('_kGooglPlex'),
    infoWindow: InfoWindow(title: 'Rahmath Hotel'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    position: LatLng(11.255551831197995, 75.78669531908251),


  );
  // static final Polyline dir = Polyline(
  //     polylineId: PolylineId('dir'),
  //     points: [
  //       LatLng(11.255551831197995, 75.78669531908251),
  //       LatLng(11.262778165300672, 75.76712065978806 ),
  //     ]
  // );
  // static final Polygon dir2 =  Polygon(
  //     polygonId: PolygonId('dir2'),
  //     points: [
  //       LatLng(11.255551831197995, 75.78669531908251),
  //       LatLng(11.262778165300672, 75.76712065978806 ),
  //       LatLng(11.25662269858871, 75.77363487380542 ),
  //       LatLng(11.256869821263898, 75.77743542142186 ),
  //       LatLng(11.25101201182461, 75.78212499637063),
  //     ],
  //     strokeWidth: 5,
  //     strokeColor: Colors.blue,
  //     fillColor: Colors.transparent,
  // );
  static final CameraPosition _kLake = CameraPosition(
      // bearing: 192.8334901395799,
      target: LatLng(11.262778165300672, 75.76712065978806),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text('Google map'),),
      body: Column(
        children: [
          Row(children: [
            Expanded(
                child: TextFormField(
                  controller: searchController ,
                  onChanged: (value) {
                    print(value); 
                  }
                )
            ),
            IconButton(onPressed:() async {
              var place = await LocationServices().getPlace(searchController.text);
              goToPlace(place);
            },
              icon: Icon(Icons.search),),
          ],),
          Expanded(
            child: GoogleMap(
              mapType: MapType.normal,
              markers: {samp,amp},
              // polylines: {dir},
              // polygons: {dir2},
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: goToPlace,
      //   label: Text('Directions'),
      //   icon: Icon(Icons.directions),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
  Future<void> goToPlace(Map<String, dynamic> place) async {
    final double lat = place['geometry']['location']['lat'];
    final double lng = place['geometry']['location']['lng'];
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: LatLng(lat, lng),
      zoom: 19,
      tilt: 59,
      bearing: 159,
      ),
    ),
    );
  }
  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  // }
}