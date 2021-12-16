import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/subscription/options/sub_registration/multiple_asset_reg/multiple_asset_registration_view.dart';
import 'package:insite/views/subscription/options/sub_registration/multiple_asset_transfer/multiple_asset_transfer_view.dart';
import 'package:insite/views/subscription/options/sub_registration/single_asset_reg/single_asset_registration_view.dart';
import 'package:insite/views/subscription/options/sub_registration/single_asset_transfer/single_asset_transfer_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SubRegistrationViewModel extends InsiteViewModel {
  Logger? log;
  NavigationService? _navigationService = locator<NavigationService>();

  SubRegistrationViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  void onRespectiveButtonClicked(AdminAssetsButtonType value) {
    if (value == AdminAssetsButtonType.SINGLEASSETREG) {
      _navigationService!.navigateWithTransition(
          SingleAssetRegistrationView(
            filterKey: "total",
            filterType: PLANTSUBSCRIPTIONFILTERTYPE.STATUS,
          ),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.SINGLEASSETTRANSFER) {
      _navigationService!.navigateWithTransition(SingleAssetTransferView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.MULTIPLEASSETREG) {
      _navigationService!.navigateWithTransition(MultipleAssetRegistrationView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.MULTIPLEASSESTTRANSFER) {
      _navigationService!.navigateWithTransition(MultipleAssetTransferView(),
          transition: "fade");
    }
  }
}
