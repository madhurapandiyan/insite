import 'package:hive/hive.dart';
import 'package:insite/core/models/filter_data.dart';
part 'asset_count_data.g.dart';

@HiveType(typeId: 3)
class AssetCountData {
  @HiveField(1)
  List<CountData>? counts;
  @HiveField(2)
  final FilterType? type;
  @HiveField(3)
  final FilterSubType? subType;
  AssetCountData({this.counts, this.type, this.subType});
}

@HiveType(typeId: 4)
class CountData {
  @HiveField(1)
  String? countOf;
  @HiveField(2)
  int? count;
  CountData({
    this.countOf,
    this.count,
  });
}
