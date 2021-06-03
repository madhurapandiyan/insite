class FilterData {
  final String title;
  final String count;
  final FilterType type;
  bool isSelected;
  FilterData({this.count, this.title, this.isSelected, this.type});
}

enum FilterType {
  ALL_ASSETS,
  PRODUCT_FAMILY,
  MAKE,
  MODEL,
  MODEL_YEAR,
  LOCATION_SEARCH,
  APPLICATION,
  ASSET_COMMISION_DATE,
  SUBSCRIPTION_DATE,
  DEVICE_TYPE
}
