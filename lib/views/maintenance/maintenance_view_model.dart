import 'package:insite/core/base/insite_view_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class MaintenanceViewModel extends InsiteViewModel {
  Logger? log;

  MaintenanceViewModel() {
    this.log = getLogger(this.runtimeType.toString());
    refresh();
  }

  //bool isListSelected = true;
  void refresh() async {
    Logger().w(appliedFilters!.length);
    await getSelectedFilterData();
    //notifyListeners();
  }
}
