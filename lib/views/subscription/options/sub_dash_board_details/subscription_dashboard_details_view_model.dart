import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class SubDashBoardDetailsViewModel extends BaseViewModel {
  Logger log;

  SubDashBoardDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  void navigateToDetails() {}
}
