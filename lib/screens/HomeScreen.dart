import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Set<Marker> _marker = {};
  String _address;
  GoogleMapController _controller;
  void _mapController(GoogleMapController controller) async {
    Position _position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    LatLng latLng = LatLng(_position.latitude, _position.longitude);

    setState(() {
      _controller = controller;
      _marker.add(Marker(
          markerId: MarkerId("id-1"),
          position: latLng,
          infoWindow: InfoWindow(
            title: "This is you location",
            // snippet: "Thi is my location "
          )));
    });
  }

  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            'My_Location',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w600, fontSize: 25),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          // isExtended: true,
          child: Icon(Icons.location_on_outlined),
          backgroundColor: Colors.black,
          onPressed: () async {
            Position _position = await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
            );
            LatLng latLng = LatLng(_position.latitude, _position.longitude);
            _controller.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: latLng, zoom: 15),
            ));
            _getAddress();
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset('assets/locImage.png')),
                        Text(
                          "Location",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0XFF00B686)),
                        ),
                        if (_address != null)
                          Text(
                            _address,
                            style: TextStyle(color: Colors.black, fontSize: 28),
                          )
                      ],
                    ),
                  );
                });
          },
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.red,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: GoogleMap(
                  // myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: _mapController,
                  markers: _marker,
                  initialCameraPosition: CameraPosition(
                      target: LatLng(22.5448131, 88.3403691), zoom: 15),
                ),
              )
            ],
          ),
        )
        // Stack(
        //   children: [
        //     Column(
        //       children: [
        //         Container(
        //           height: 220,
        //           decoration: BoxDecoration(
        //             gradient: LinearGradient(
        //                 colors: [Color(0XFF00B686), Color(0XFF00838F)]),
        //           ),
        //           child: Padding(
        //             padding:
        //                 const EdgeInsets.only(left: 20, right: 20.0, top: 30),
        //             child: Column(
        //               children: [
        //                 Row(
        //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //                   children: [
        //                     Text(
        //                       " Location ",
        //                       style: TextStyle(
        //                         fontSize: 18.0,
        //                         fontWeight: FontWeight.w600,
        //                         color: Colors.white,
        //                       ),
        //                     ),
        //                     IconButton(
        //                         onPressed: () async {
        //                           await _auth.signOut();
        //                           Navigator.push(
        //                               context,
        //                               MaterialPageRoute(
        //                                   builder: (context) => LoginScreen()));
        //                         },
        //                         icon: Icon(
        //                           Icons.login_outlined,
        //                           color: Colors.white,
        //                         ))
        //                   ],
        //                 ),
        //                 SizedBox(
        //                   height: 20,
        //                 ),
        //               ],
        //             ),
        //           ),
        //         ),
        //         Expanded(
        //           child: Container(
        //             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        //             color: Colors.grey.shade100,
        //             child: Stack(
        //               children: [
        //                 GoogleMap(
        //                   // myLocationEnabled: true,
        //                   zoomControlsEnabled: false,
        //                   onMapCreated: _mapController,
        //                   markers: _marker,
        //                   initialCameraPosition: CameraPosition(
        //                       target: LatLng(22.5448131, 88.3403691), zoom: 15),
        //                 ),
        //                 Positioned(
        //                     top: 15,
        //                     right: 8,
        //                     child: IconButton(
        //                       onPressed: () async {
        //                         Position _position =
        //                             await Geolocator.getCurrentPosition(
        //                           desiredAccuracy: LocationAccuracy.high,
        //                         );
        //                         LatLng latLng = LatLng(
        //                             _position.latitude, _position.longitude);
        //                         _controller
        //                             .animateCamera(CameraUpdate.newCameraPosition(
        //                           CameraPosition(target: latLng, zoom: 15),
        //                         ));
        //                         _getAddress();
        //                       },
        //                       icon: Icon(
        //                         Icons.pin_drop_rounded,
        //                         color: Color(0XFF00B686),
        //                       ),
        //                       iconSize: 40.0,
        //                     )),
        //               ],
        //             ),
        //           ),
        //         )
        //       ],
        //     ),
        //     Positioned(
        //       top: 78,
        //       right: 0,
        //       child: Container(
        //         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        //         width: MediaQuery.of(context).size.width * 0.85,
        //         height: 100,
        //         decoration: BoxDecoration(
        //             color: Colors.white,
        //             boxShadow: [
        //               BoxShadow(
        //                 color: Colors.black.withOpacity(.05),
        //                 blurRadius: 8,
        //                 spreadRadius: 3,
        //                 offset: Offset(0, 10),
        //               ),
        //             ],
        //             borderRadius: BorderRadius.only(
        //               topLeft: Radius.circular(10),
        //               bottomLeft: Radius.circular(50),
        //             )),
        //         child: Column(
        //           children: [
        //             Row(
        //               children: [
        //                 Icon(Icons.location_on_outlined),
        //                 SizedBox(
        //                   width: 8,
        //                 ),
        //                 Expanded(
        //                   child: Column(
        //                     crossAxisAlignment: CrossAxisAlignment.start,
        //                     children: [
        //                       Text(
        //                         "Location",
        //                         style: TextStyle(
        //                             fontWeight: FontWeight.bold,
        //                             color: Color(0XFF00B686)),
        //                       ),
        //                       if (_address != null)
        //                         Text(
        //                           _address,
        //                           style: Theme.of(context).textTheme.bodyText1,
        //                         )
        //                     ],
        //                   ),
        //                 )
        //               ],
        //             )
        //           ],
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        );
  }

  _getAddress() async {
    Position _position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    try {
      var p = await placemarkFromCoordinates(
          _position.latitude, _position.longitude);
      Placemark placemark = p[0];
      setState(() {
        _address =
            "${placemark.street},${placemark.locality},\n${placemark.postalCode},${placemark.country}";
      });
      print(_address);
    } catch (e) {
      print(e);
    }
  }
}
