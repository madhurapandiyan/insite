import 'package:insite/utils/enums.dart';

class Category {
  final int id;
  final String name;
  final String image;
  final ScreenType screenType;
  Category(
    this.id,
    this.name,
    this.image,
    this.screenType,
  );
}

List<Category>? showsCategoryBasedOnAccountSelection(bool isTataHitachi) {
  if (isTataHitachi) {
    categories = [
      Category(1, "DASHBOARD", "assets/images/dashboardicon.svg",
          ScreenType.DASHBOARD),
      Category(2, "FLEET", "assets/images/fleeticon.svg", ScreenType.FLEET),
      Category(3, "UTILIZATION", "assets/images/utilizationicon.svg",
          ScreenType.UTILIZATION),
      Category(4, "ASSET OPERATION", "assets/images/asset_operationicon.svg",
          ScreenType.ASSET_OPERATION),
      Category(
          5, "LOCATION", "assets/images/location.svg", ScreenType.LOCATION),
      Category(6, "HEALTH", "assets/images/healthicon.svg", ScreenType.HEALTH),
      Category(7, "MAINTENANCE", "assets/images/maintenanceicon.svg",
          ScreenType.MAINTENANCE),
      Category(8, "ADMINISTRATOR", "assets/images/adminisitratoricon.svg",
          ScreenType.ADMINISTRATION),
      Category(9, "PLANT", "assets/images/plant.svg", ScreenType.PLANT),
      Category(
          10, "SUBSCRIPTION", "assets/images/sub.svg", ScreenType.SUBSCRIPTION),
      Category(11, "NOTIFICATIONS", "assets/images/noti.svg",
          ScreenType.NOTIFICATIONS)
    ];
    return categories;
  } else {
    categories = [
      Category(1, "DASHBOARD", "assets/images/dashboardicon.svg",
          ScreenType.DASHBOARD),
      Category(2, "FLEET", "assets/images/fleeticon.svg", ScreenType.FLEET),
      Category(3, "UTILIZATION", "assets/images/utilizationicon.svg",
          ScreenType.UTILIZATION),
      Category(4, "ASSET OPERATION", "assets/images/asset_operationicon.svg",
          ScreenType.ASSET_OPERATION),
      Category(
          5, "LOCATION", "assets/images/location.svg", ScreenType.LOCATION),
      Category(6, "HEALTH", "assets/images/healthicon.svg", ScreenType.HEALTH),
      Category(7, "MAINTENANCE", "assets/images/maintenanceicon.svg",
          ScreenType.MAINTENANCE),
      Category(8, "ADMINISTRATOR", "assets/images/adminisitratoricon.svg",
          ScreenType.ADMINISTRATION),
     //  Category(9, "PLANT", "assets/images/plant.svg", ScreenType.PLANT),
      // Category(
      //    10, "SUBSCRIPTION", "assets/images/sub.svg", ScreenType.SUBSCRIPTION),
      Category(11, "NOTIFICATIONS", "assets/images/noti.svg",
          ScreenType.NOTIFICATIONS)
    ];
    return categories;
  }
}

List<Category>? categories;

// List<Category> categories = [
//   Category(1, "DASHBOARD", "assets/images/clock.svg", ScreenType.DASHBOARD),
//   Category(2, "FLEET", "assets/images/truck.svg", ScreenType.FLEET),
//   Category(3, "UTILIZATION", "assets/images/supportmanager.svg",
//       ScreenType.UTILIZATION),
//   Category(4, "ASSET OPERATION", "assets/images/assetmanager.svg",
//       ScreenType.ASSET_OPERATION),
//   Category(5, "LOCATION", "assets/images/location.svg", ScreenType.LOCATION),
//   Category(6, "HEALTH", "assets/images/van.svg", ScreenType.HEALTH),
//   //Category(7, "MAINTENANCE", "assets/images/maint.svg", ScreenType.MAINTENANCE),
//   Category(8, "ADMINISTRATION", "assets/images/admin.svg",
//       ScreenType.ADMINISTRATION),
//   Category(9, "PLANT", "assets/images/plant.svg", ScreenType.PLANT),
//   Category(
//       10, "SUBSCRIPTION", "assets/images/sub.svg", ScreenType.SUBSCRIPTION),
//   Category(
//       11, "NOTIFICATIONS", "assets/images/noti.svg", ScreenType.NOTIFICATIONS)
// ];
