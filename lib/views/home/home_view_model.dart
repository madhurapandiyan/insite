import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class HomeViewModel extends BaseViewModel {
  Logger log;

  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
