import 'package:new_coronavirus/api/make_request.dart';
import 'package:new_coronavirus/models/ResponseStatus.dart';
import 'package:http/http.dart' as http;

class HomeNetwork {
  static Future<ResponseStatus> getNationalData([http.Client client]) async {
    try {
      dynamic decodedJson = await MakeRequest.get(DataType.national, client);
    } catch (e) {
      return ResponseStatus(false, "Si è verificato un errore");
    }
  }

  static Future<ResponseStatus> getRegionalData([http.Client client]) async {
    try {
      dynamic decodedJson = await MakeRequest.get(DataType.regional, client);
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
