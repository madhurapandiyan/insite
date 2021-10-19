import 'package:insite/core/base/insite_view_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class AddgeofenseViewModel extends InsiteViewModel {
  Logger log;

  AddgeofenseViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
