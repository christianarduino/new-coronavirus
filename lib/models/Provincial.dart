class Provincial {
  String name, originCode, regionalName;
  double lat, lon;
  int totalCases;

  Provincial.fromJson(Map<String, dynamic> json)
      : name = json['denominazione_provincia'],
        originCode = json['sigla_provincia'],
        regionalName = json['denominazione_regione'],
        lat = json['lat'] == 0 ? 0.0 : json['lat'],
        lon = json['long'] == 0 ? 0.0 : json['long'],
        totalCases = json['totale_casi'];
}
