import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_coronavirus/models/Regional.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';

class MapFullscreenPage extends StatelessWidget {
  final Regional regional;

  const MapFullscreenPage({Key key, this.regional}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Completer<GoogleMapController> _controller = Completer();
    return Scaffold(
      appBar: AppBar(
        title: Text("Mappa ${regional.name}"),
      ),
      body: StoreConnector<AppState, Set<Marker>>(
        converter: (store) => store.state.markers[regional.name],
        builder: (_, markers) {
          return GoogleMap(
            markers: markers,
            initialCameraPosition: CameraPosition(
              target: LatLng(regional.latitude, regional.longitude),
              zoom: 7.17,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
              Factory<OneSequenceGestureRecognizer>(
                () => EagerGestureRecognizer(),
              ),
            ].toSet(),
          );
        },
      ),
    );
  }
}
