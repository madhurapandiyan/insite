import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/logger.dart';
import 'package:logger/logger.dart';

class EstimatedVoumePayloadMileage extends InsiteViewModel {
  Logger log;

  EstimatedVoumePayloadMileage() {
    this.log = getLogger(this.runtimeType.toString());
  }
}