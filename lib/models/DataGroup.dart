import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/models/Regional.dart';

class DataGroup {
  final List<National> national;
  final List<Regional> regional;

  DataGroup({this.national, this.regional});
}
