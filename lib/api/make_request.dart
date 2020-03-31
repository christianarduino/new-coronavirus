import 'dart:convert';

import 'errors.dart';
import 'dart:io' show SocketException, HttpException;
import 'package:http/http.dart' as http;

enum DataType { national, regional, provincial }

class MakeRequest {
  static final String nationalData =
      "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-andamento-nazionale.json";
  static final String regionalData =
      "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-regioni-latest.json";
  static final String provincialData =
      "https://raw.githubusercontent.com/pcm-dpc/COVID-19/master/dati-json/dpc-covid19-ita-province-latest.json";

  static Map<String, String> headers = {
    "Content-Type": "application/json",
  };

  static Future<Map<String, dynamic>> get(DataType type,
      [http.Client client]) async {
    try {
      http.Response response;
      if (client == null) {
        response = await http.get(
          getUrl(type),
          headers: headers,
        );
      } else {
        response = await client.get(
          getUrl(type),
          headers: headers,
        );
      }

      final responseJson = await jsonDecode(response.body);

      if (response.statusCode < 300) {
        //if success
        return {'error': false, 'data': responseJson};
      } else {
        return {'error': false};
      }
    } on SocketException {
      throw NoInternetException(
        "Nessuna connesione internet.\nAssicurati di avere il wifi o la connessione dati attiva",
      );
    } on HttpException {
      print("FROM HTTP EXCEPTION");
      throw NoServiceFoundException("Si è verificato un errore. Riprova");
    } on FormatException {
      print("FROM FORMAT EXCEPTION");
      throw InvalidFormatException(
        "C'è un errore nei dati.",
      );
    } catch (e) {
      print(e);
      throw UnknownException("Si è verificato un errore. Riprova");
    }
  }

  static String getUrl(DataType type) {
    switch (type) {
      case DataType.national:
        return nationalData;
      case DataType.regional:
        return regionalData;
      case DataType.provincial:
        return provincialData;
      default:
        return nationalData;
    }
  }
}
