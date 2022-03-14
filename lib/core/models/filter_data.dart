import 'package:hive/hive.dart';
part 'filter_data.g.dart';

@HiveType(typeId: 0)
class FilterData {
  @HiveField(0)
  final String? title;
  @HiveField(1)
  final String? count;
  @HiveField(2)
  final FilterType? type;
  @HiveField(3)
  bool? isSelected;
  @HiveField(4)
  List<String?>? extras;
  @HiveField(5)
  final FilterSubType? subType;
  @HiveField(6)
  final String? id;

  FilterData(
      {this.count,
      this.title,
      this.isSelected,
      this.type,
      this.extras,
      this.subType,
      this.id});
}

@HiveType(typeId: 1)
enum FilterType {
  @HiveField(0)
  ALL_ASSETS,
  @HiveField(1)
  PRODUCT_FAMILY,
  @HiveField(2)
  MAKE,
  @HiveField(3)
  MODEL,
  @HiveField(4)
  MODEL_YEAR,
  @HiveField(5)
  LOCATION_SEARCH,
  @HiveField(6)
  APPLICATION,
  @HiveField(7)
  ASSET_COMMISION_DATE,
  @HiveField(8)
  SUBSCRIPTION_DATE,
  @HiveField(9)
  DEVICE_TYPE,
  @HiveField(10)
  FUEL_LEVEL,
  @HiveField(11)
  IDLING_LEVEL,
  @HiveField(12)
  DATE_RANGE,
  @HiveField(13)
  CLUSTOR,
  @HiveField(14)
  ASSET_STATUS,
  @HiveField(15)
  SEVERITY,
  @HiveField(16)
  JOBTYPE,
  @HiveField(17)
  USERTYPE,
  @HiveField(18)
  FREQUENCYTYPE,
  @HiveField(19)
  REPORT_FORMAT,
  @HiveField(20)
  REPORT_TYPE
}

@HiveType(typeId: 2)
enum FilterSubType {
  @HiveField(0)
  DAY,
  @HiveField(1)
  WEEK,
  @HiveField(2)
  MONTH,
}
