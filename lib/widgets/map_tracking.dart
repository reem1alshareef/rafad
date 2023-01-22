import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:location/location.dart';
import 'package:rafad1/screens/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MapTracking extends StatefulWidget {
  const MapTracking({super.key});

  @override
  State<MapTracking> createState() => _MapTrackingState();
}

class _MapTrackingState extends State<MapTracking> {
  late GoogleMapController googleMapController;
  final Completer<GoogleMapController> _controller = Completer();
  static const LatLng sourceLocation = LatLng(37.33500926,
      -122.03272188); //هذي الارقام هل تعتمد على الموقع اللي ابغاه ؟
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  // method for current location
  void getCurrentLocation() async {
    Location location = Location();
    location.getLocation().then(
      (location) {
        currentLocation = location;
      },
    );
    GoogleMapController googleMapController = await _controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
                zoom: 13.5,
                target: LatLng(
                  newLoc.latitude!,
                  newLoc.longitude!,
                )),
          ),
        );

        setState(() {});
      },
    );
  }

  //method for
  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assests/images/pin_source.png")
        .then(
      (icon) {
        sourceIcon = icon;
      },
    );
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assests/images/pin_distnation.png")
        .then(
      (icon) {
        destinationIcon = icon;
      },
    );

    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assests/images/icon_pilgrim.png")
        .then(
      (icon) {
        currentLocationIcon = icon;
      },
    );
  }

// method for polylines and route
  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      google_api_key,
      PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
      PointLatLng(destination.latitude, destination.longitude),
    );
    if (result.points.isEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      ); //end for each
      setState(() {});
    } // end if
  }

  @override
  void initState() {
    getCurrentLocation(); // call curren location
    setCustomMarkerIcon();
    getPolyPoints(); //here call for this function
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Track Campaign",
            style: TextStyle(color: Color.fromARGB(255, 5, 0, 0), fontSize: 16),
          ),
        ),
        body: currentLocation == null
            ? const Center(child: Text("Loading"))
            : GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                      currentLocation!.latitude!,
                      currentLocation!
                          .longitude!), //اول كان التارقت السورس لوكيشن
                  zoom: 14.5,
                ),
                //for route Map
                polylines: {
                  Polyline(
                    polylineId: PolylineId("route"),
                    points: polylineCoordinates,
                    color: primaryColor,
                    width: 6,
                  ),
                },
                markers: {
                  // هي العلامة اللي توضع على اللوكيشين
                  Marker(
                    //علامة الموقع الحالي يحدده
                    markerId: const MarkerId("currentLocation"),
                    icon: currentLocationIcon,
                    position: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                  ),
                  Marker(
                    markerId: MarkerId("source"),
                    icon: sourceIcon,
                    position: sourceLocation,
                  ),
                  Marker(
                    markerId: MarkerId("distnation"),
                    icon: destinationIcon,
                    position: destination,
                  ),
                },
                onMapCreated: (GoogleMapController mapController) {
                  _controller.complete(mapController);
                  googleMapController = mapController;
                }));
  }
}
