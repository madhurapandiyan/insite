import 'package:insite/core/base/insite_view_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class MaintenanceViewModel extends InsiteViewModel {
  Logger? log;

  MaintenanceViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  bool isListSelected = true;
}
