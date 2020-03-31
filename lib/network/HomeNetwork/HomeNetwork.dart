import 'package:new_coronavirus/api/MakeRequest.dart';
import 'package:new_coronavirus/models/National.dart';
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
          .toList()
          .reversed
          .toList();

      print(nationals[0].dead);
      return ResponseStatus(true, nationals);
    } catch (e) {
      print(e);
      return ResponseStatus(false, "Si è verificato un errore");
    }
  }

  static Future<ResponseStatus> getRegionalData([http.Client client]) async {
    try {
      dynamic decodedJson = await MakeRequest.get(DataType.regional, client);

      if (decodedJson['error'])
        return ResponseStatus(false, "Si è verificato un errore");

      List<dynamic> jsonRegional = List.from(decodedJson['data']);
      List<Regional> regional = jsonRegional
          .map<Regional>((json) => Regional.fromJson(json))
          .toList();

      return ResponseStatus(true, regional);
    } catch (e) {
      return ResponseStatus(false, "Si è verificato un errore");
    }
  }

  static Future<ResponseStatus> getProvincialData([http.Client client]) async {
    try {
      dynamic decodedJson = await MakeRequest.get(DataType.provincial, client);
    } catch (e) {
      return ResponseStatus(false, "Si è verificato un errore");
    }
  }
}
