import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class SingleAssetOperationViewModel extends BaseViewModel {
  Logger log;

  SingleAssetOperationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
