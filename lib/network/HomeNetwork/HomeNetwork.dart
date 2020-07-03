import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:new_coronavirus/api/MakeRequest.dart';
import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/models/Provincial.dart';
import 'package:new_coronavirus/models/Regional.dart';
import 'package:new_coronavirus/models/ResponseStatus.dart';
import 'package:http/http.dart' as http;

class HomeNetwork {
  static Future<ResponseStatus> getNationalData([http.Client client]) async {
    try {
      Map decodedJson = await MakeRequest.get(DataType.national, client);

      if (decodedJson['error'])
        return ResponseStatus(false, "Si è verificato un errore");

      List<dynamic> jsonNationals = List.from(decodedJson['data']);
      List<National> nationals = jsonNationals
          .map<National>((json) => National.fromJson(json))
          .toList();

      nationals.sort(
        (National a, National b) => b.dead.compareTo(a.dead),
      );
      return ResponseStatus(true, nationals);
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Si è verificato un errore");
    }
  }

  static Future<ResponseStatus> getRegionalData(bool latest,
      [http.Client client]) async {
    try {
      dynamic decodedJson = await MakeRequest.get(
          latest ? DataType.regionalLatest : DataType.regional, client);

      if (decodedJson['error'])
        return ResponseStatus(false, "Si è verificato un errore");

      List<dynamic> jsonRegional = List.from(decodedJson['data']);

      if (latest) {
        List<dynamic> jsonRegional = List.from(decodedJson['data']);
        List<Regional> regionalList = jsonRegional
            .map<Regional>((json) => Regional.fromJson(json))
            .toList();
        return ResponseStatus(true, regionalList);
      } else {
        Map<String, List<Regional>> regionalMap = {};
        jsonRegional.forEach((item) {
          Regional regional = Regional.fromJson(item);
          if (!regionalMap.containsKey(regional.name))
            regionalMap[regional.name] = <Regional>[];

          regionalMap[regional.name].add(regional);
        });

        regionalMap.forEach((String key, List<Regional> regional) {
          regional.sort((Regional a, Regional b) => b.date.compareTo(a.date));
        });

        return ResponseStatus(true, regionalMap);
      }
    } catch (e) {
      return ResponseStatus(false, "Si è verificato un errore");
    }
  }

  static Future<ResponseStatus> getProvincialData([http.Client client]) async {
    try {
      dynamic decodedJson = await MakeRequest.get(DataType.provincial, client);

      if (decodedJson['error'])
        return ResponseStatus(false, "Si è verificato un errore");

      Map<String, Set<Marker>> markers = {};
      Map<String, List<Provincial>> mapProvincial = {};
      List<dynamic> jsonRegional = List.from(decodedJson['data']);
      jsonRegional.forEach((json) {
        Provincial provincial = Provincial.fromJson(json);

        //map provincial
        if (!mapProvincial.containsKey(provincial.regionalName)) {
          mapProvincial[provincial.regionalName] = [];
        }
        mapProvincial[provincial.regionalName].add(provincial);

        //markers
        if (provincial.hasCoordinate) {
          if (provincial.lon != 0.0 && provincial.lat != 0.0) {
            LatLng coordinate = LatLng(provincial.lat, provincial.lon);
            CameraPosition position = CameraPosition(target: coordinate);
            if (!markers.containsKey(provincial.regionalName)) {
              markers[provincial.regionalName] = Set<Marker>();
            }
            Marker marker = Marker(
              markerId: MarkerId(position.toString()),
              position: coordinate,
              infoWindow: InfoWindow(
                title: "${provincial.name} - ${provincial.originCode}",
                snippet: 'Casi totali: ${provincial.totalCases.toString()}',
              ),
              icon: BitmapDescriptor.defaultMarker,
            );
            markers[provincial.regionalName].add(marker);
          }
        }
      });

      return ResponseStatus(true, {"markers": markers, "map": mapProvincial});
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Si è verificato un errore");
    }
  }
}
