import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/models/Provincial.dart';
import 'package:new_coronavirus/models/Regional.dart';

class AppState {
  List<National> nationals;
  Map<String, List<Regional>> regional;
  List<Regional> regionalLatest;
  Map<String, List<Provincial>> provincialLatest;
  Map<String, Set<Marker>> markers;
}
