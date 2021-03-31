import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class CustomerSelectionViewModel extends BaseViewModel {
  Logger log;

  CustomerSelectionViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

}
