import 'package:new_coronavirus/models/National.dart';
import 'package:new_coronavirus/models/Regional.dart';

class AppState {
  List<National> nationals;
  Map<String, List<Regional>> regional;
  List<Regional> regionalLatest;
}
