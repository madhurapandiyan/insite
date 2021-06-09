import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class TotalFuelBurnedViewModel extends BaseViewModel {
  Logger log;

  TotalFuelBurnedViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
