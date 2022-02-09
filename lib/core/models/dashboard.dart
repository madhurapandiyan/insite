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

final List<Category> categories = [
  Category(1, "DASHBOARD", "assets/images/clock.svg", ScreenType.DASHBOARD),
  Category(2, "FLEET", "assets/images/truck.svg", ScreenType.FLEET),
  Category(3, "UTILIZATION", "assets/images/supportmanager.svg",
      ScreenType.UTILIZATION),
  Category(4, "ASSET OPERATION", "assets/images/assetmanager.svg",
      ScreenType.ASSET_OPERATION),
  Category(5, "LOCATION", "assets/images/location.svg", ScreenType.LOCATION),
  Category(6, "HEALTH", "assets/images/van.svg", ScreenType.HEALTH),
  // Category(7, "MAINTENANCE", "assets/images/maint.svg", ScreenType.MAINTENANCE),
  Category(8, "ADMINISTRATION", "assets/images/admin.svg",
      ScreenType.ADMINISTRATION),
  Category(9, "PLANT", "assets/images/plant.svg", ScreenType.PLANT),
  Category(
      10, "SUBSCRIPTION", "assets/images/sub.svg", ScreenType.SUBSCRIPTION),
  Category(
      11, "NOTIFICATION", "assets/images/noti.svg", ScreenType.NOTIFICATION)
];
