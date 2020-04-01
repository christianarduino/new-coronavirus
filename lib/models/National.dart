class National {
  DateTime date;
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
      : date = DateTime.parse(json['data']),
        recovered = json['dimessi_guariti'],
        dead = json['deceduti'],
        totalCases = json['totale_casi'],
        swab = json['tamponi'],
        totalInfected = json['totale_positivi'],
        newInfected = json['nuovi_positivi'];
}
