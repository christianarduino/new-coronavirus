import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/models/Regional.dart';

class DataGroup {
  final List<National> national;
  final Map<String, List<Regional>> regional;
  final List<Regional> regionalLatest;

  DataGroup({this.national, this.regional, this.regionalLatest});
}
