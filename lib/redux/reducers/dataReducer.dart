import 'package:new_coronavirus/models/DataGroup.dart';
import 'package:new_coronavirus/redux/actions/DataActions.dart';
import 'package:new_coronavirus/redux/store/AppState.dart';

AppState dataReducer(AppState state, dynamic action) {
  switch (action.type) {
    case DataActions.Save:
      DataGroup dataGroup = action.payload as DataGroup;
      state.national = dataGroup.national;
      state.regional = dataGroup.regional;
      return state;
    default:
      return state;
  }
}
