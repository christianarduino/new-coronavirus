import 'package:new_coronavirus/utils/functions.dart';

class National {
  final String date;
  final int recovered, dead, totalCases, swab, totalInfected, newInfected;

  National(
    this.date,
    this.recovered,
    this.dead,
    this.totalCases,
    this.swab,
    this.totalInfected,
    this.newInfected,
  );

  National.fromJson(Map<String, dynamic> json)
      : date = dateWithSlash(json['data']),
        recovered = json['dimessi_guariti'],
        dead = json['deceduti'],
        totalCases = json['totale_casi'],
        swab = json['tamponi'],
        totalInfected = json['totale_ospedalizzati'],
        newInfected = json['nuovi_positivi'];
}
