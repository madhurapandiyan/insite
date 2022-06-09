import 'package:insite/core/flavor/flavor.dart';
import 'package:insite/theme/colors.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart' as snack_bar_service;
import 'locator.dart';
import 'logger.dart';

class SnackbarStyling {
  static Logger log = getLogger('Locator Injector');
  static void setupSnackbarUi() {
    log.d('Registering snackbar styling');
    final service = locator<snack_bar_service.SnackbarService>();

    // Registers a config to be used when calling showSnackbar
    service.registerSnackbarConfig(snack_bar_service.SnackbarConfig(
        //messageColor: tango,
        messageColor: white,
        mainButtonTextColor: white,
        backgroundColor: AppConfig.instance!.productFlavor == "tatahitachi" ||
                AppConfig.instance!.productFlavor == "unifiedFleet"
            ? tango
            : buttonColor1,
        textColor: tango));
  }
}
