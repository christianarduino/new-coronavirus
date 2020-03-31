import 'package:new_coronavirus/models/DataGroup.dart';

enum DataActions { Save }

class SaveData {
  DataActions type = DataActions.Save;
  final DataGroup payload;

  SaveData(this.payload);
}
