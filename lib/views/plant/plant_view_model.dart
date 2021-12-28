import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/plant/dashboard/plant_dashboard_view.dart';
import 'package:insite/views/plant/plant_asset_creation/plant_asset_creation_view.dart';
import 'package:insite/views/plant/plant_hierachy/plant_hierachy_view.dart';
import 'package:logger/logger.dart';
import 'package:insite/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class PlantViewModel extends InsiteViewModel {
  Logger? log;
  NavigationService? _navigationService = locator<NavigationService>();

  PlantViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void onRespectiveButtonClicked(AdminAssetsButtonType value) {
    Logger().i("onRespectiveButtonClicked $value");
    if (value == AdminAssetsButtonType.VIEWDASHBOARD) {
      _navigationService!.navigateWithTransition(PlantDashboardView(),
          transition: "fade");
    } else if (value == AdminAssetsButtonType.VIEWHIERACHY) {
      navigationService!.navigateWithTransition(PlantHierachyView(),
          transition: "fade");
    }
  }

  void goToPlantAssetCreationPage() {
    _navigationService!.navigateWithTransition(PlantAssetCreationView(),
        transition: "fade");
  }
}
