import 'package:insite/core/base/insite_view_model.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:insite/core/logger.dart';

class SingleAssetTransferViewModel extends InsiteViewModel {
  Logger log;

  SingleAssetTransferViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
