// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FilterDataAdapter extends TypeAdapter<FilterData> {
  @override
  final int typeId = 0;

  @override
  FilterData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FilterData(
      count: fields[1] as String?,
      title: fields[0] as String?,
      isSelected: fields[3] as bool?,
      type: fields[2] as FilterType?,
      extras: (fields[4] as List?)?.cast<String?>(),
      subType: fields[5] as FilterSubType?,
      id: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FilterData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.count)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.isSelected)
      ..writeByte(4)
      ..write(obj.extras)
      ..writeByte(5)
      ..write(obj.subType)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FilterTypeAdapter extends TypeAdapter<FilterType> {
  @override
  final int typeId = 1;

  @override
  FilterType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FilterType.ALL_ASSETS;
      case 1:
        return FilterType.PRODUCT_FAMILY;
      case 2:
        return FilterType.MAKE;
      case 3:
        return FilterType.MODEL;
      case 4:
        return FilterType.MODEL_YEAR;
      case 5:
        return FilterType.LOCATION_SEARCH;
      case 6:
        return FilterType.APPLICATION;
      case 7:
        return FilterType.ASSET_COMMISION_DATE;
      case 8:
        return FilterType.SUBSCRIPTION_DATE;
      case 9:
        return FilterType.DEVICE_TYPE;
      case 10:
        return FilterType.FUEL_LEVEL;
      case 11:
        return FilterType.IDLING_LEVEL;
      case 12:
        return FilterType.DATE_RANGE;
      case 13:
        return FilterType.CLUSTOR;
      case 14:
        return FilterType.ASSET_STATUS;
      case 15:
        return FilterType.SEVERITY;
      case 16:
        return FilterType.JOBTYPE;
      case 17:
        return FilterType.USERTYPE;
      case 18:
        return FilterType.FREQUENCYTYPE;
      case 19:
        return FilterType.REPORT_FORMAT;
      case 20:
        return FilterType.REPORT_TYPE;
      case 21:
        return FilterType.MANUFACTURER;
      default:
        return FilterType.ALL_ASSETS;
    }
  }

  @override
  void write(BinaryWriter writer, FilterType obj) {
    switch (obj) {
      case FilterType.ALL_ASSETS:
        writer.writeByte(0);
        break;
      case FilterType.PRODUCT_FAMILY:
        writer.writeByte(1);
        break;
      case FilterType.MAKE:
        writer.writeByte(2);
        break;
      case FilterType.MODEL:
        writer.writeByte(3);
        break;
      case FilterType.MODEL_YEAR:
        writer.writeByte(4);
        break;
      case FilterType.LOCATION_SEARCH:
        writer.writeByte(5);
        break;
      case FilterType.APPLICATION:
        writer.writeByte(6);
        break;
      case FilterType.ASSET_COMMISION_DATE:
        writer.writeByte(7);
        break;
      case FilterType.SUBSCRIPTION_DATE:
        writer.writeByte(8);
        break;
      case FilterType.DEVICE_TYPE:
        writer.writeByte(9);
        break;
      case FilterType.FUEL_LEVEL:
        writer.writeByte(10);
        break;
      case FilterType.IDLING_LEVEL:
        writer.writeByte(11);
        break;
      case FilterType.DATE_RANGE:
        writer.writeByte(12);
        break;
      case FilterType.CLUSTOR:
        writer.writeByte(13);
        break;
      case FilterType.ASSET_STATUS:
        writer.writeByte(14);
        break;
      case FilterType.SEVERITY:
        writer.writeByte(15);
        break;
      case FilterType.JOBTYPE:
        writer.writeByte(16);
        break;
      case FilterType.USERTYPE:
        writer.writeByte(17);
        break;
      case FilterType.FREQUENCYTYPE:
        writer.writeByte(18);
        break;
      case FilterType.REPORT_FORMAT:
        writer.writeByte(19);
        break;
      case FilterType.REPORT_TYPE:
        writer.writeByte(20);
        break;
      case FilterType.MANUFACTURER:
        writer.writeByte(21);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FilterSubTypeAdapter extends TypeAdapter<FilterSubType> {
  @override
  final int typeId = 2;

  @override
  FilterSubType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return FilterSubType.DAY;
      case 1:
        return FilterSubType.WEEK;
      case 2:
        return FilterSubType.MONTH;
      default:
        return FilterSubType.DAY;
    }
  }

  @override
  void write(BinaryWriter writer, FilterSubType obj) {
    switch (obj) {
      case FilterSubType.DAY:
        writer.writeByte(0);
        break;
      case FilterSubType.WEEK:
        writer.writeByte(1);
        break;
      case FilterSubType.MONTH:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterSubTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FilterData _$FilterDataFromJson(Map<String, dynamic> json) => FilterData(
      count: json['count'] as String?,
      title: json['title'] as String?,
      isSelected: json['isSelected'] as bool?,
      type: _$enumDecodeNullable(_$FilterTypeEnumMap, json['type']),
      extras:
          (json['extras'] as List<dynamic>?)?.map((e) => e as String?).toList(),
      subType: _$enumDecodeNullable(_$FilterSubTypeEnumMap, json['subType']),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$FilterDataToJson(FilterData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'count': instance.count,
      'type': _$FilterTypeEnumMap[instance.type],
      'isSelected': instance.isSelected,
      'extras': instance.extras,
      'subType': _$FilterSubTypeEnumMap[instance.subType],
      'id': instance.id,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$FilterTypeEnumMap = {
  FilterType.ALL_ASSETS: 'ALL_ASSETS',
  FilterType.PRODUCT_FAMILY: 'PRODUCT_FAMILY',
  FilterType.MAKE: 'MAKE',
  FilterType.MODEL: 'MODEL',
  FilterType.MODEL_YEAR: 'MODEL_YEAR',
  FilterType.LOCATION_SEARCH: 'LOCATION_SEARCH',
  FilterType.APPLICATION: 'APPLICATION',
  FilterType.ASSET_COMMISION_DATE: 'ASSET_COMMISION_DATE',
  FilterType.SUBSCRIPTION_DATE: 'SUBSCRIPTION_DATE',
  FilterType.DEVICE_TYPE: 'DEVICE_TYPE',
  FilterType.FUEL_LEVEL: 'FUEL_LEVEL',
  FilterType.IDLING_LEVEL: 'IDLING_LEVEL',
  FilterType.DATE_RANGE: 'DATE_RANGE',
  FilterType.CLUSTOR: 'CLUSTOR',
  FilterType.ASSET_STATUS: 'ASSET_STATUS',
  FilterType.SEVERITY: 'SEVERITY',
  FilterType.JOBTYPE: 'JOBTYPE',
  FilterType.USERTYPE: 'USERTYPE',
  FilterType.FREQUENCYTYPE: 'FREQUENCYTYPE',
  FilterType.REPORT_FORMAT: 'REPORT_FORMAT',
  FilterType.REPORT_TYPE: 'REPORT_TYPE',
  FilterType.MANUFACTURER: 'MANUFACTURER',
};

const _$FilterSubTypeEnumMap = {
  FilterSubType.DAY: 'DAY',
  FilterSubType.WEEK: 'WEEK',
  FilterSubType.MONTH: 'MONTH',
};
