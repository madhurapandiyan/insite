import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class GlobalSearchViewModel extends BaseViewModel {
  Logger log;

  GlobalSearchViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
