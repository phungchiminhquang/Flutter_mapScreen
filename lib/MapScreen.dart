import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Set<Marker> _marker = {};
  GoogleMapController? controller;
  BitmapDescriptor? _markerIcon;
  void onMapCreated() {
    setState(() {
      _marker.add(Marker(
          markerId: MarkerId("test"),
          position: LatLng(10.877611249724893, 106.80955616597318),
          icon: _markerIcon!));
    });
  }

  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("Map Screen"),
        ),
        body: GoogleMap(
            onMapCreated: _onMapCreated,
            markers: <Marker>{_createMarker()},
            initialCameraPosition: CameraPosition(
                target: LatLng(10.877611249724893, 106.80955616597318),
                zoom: 15)));
  }

  Marker _createMarker() {
    if (_markerIcon != null) {
      return Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(10.877611249724893, 106.80955616597318),
        icon: _markerIcon!,
      );
    } else {
      return Marker(
        markerId: MarkerId("marker_1"),
        position: LatLng(10.877611249724893, 106.80955616597318),
      );
    }
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size.square(20));
      BitmapDescriptor.fromAssetImage(
              imageConfiguration, 'assets/b.png')
          .then(_updateBitmap);
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }
}
