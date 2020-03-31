import 'package:new_coronavirus/models/National.dart';

class Regional extends National {
  int regionCode;
  String name;
  double latitude, longitude;

  Regional.fromJson(Map<String, dynamic> json)
      : regionCode = json['codice_regione'],
        name = json['denominazione_regione'],
        latitude = json['lat'],
        longitude = json['lon'],
        super.fromJson(json);
}
