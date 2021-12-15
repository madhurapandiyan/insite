// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_count_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AssetCountDataAdapter extends TypeAdapter<AssetCountData> {
  @override
  final int typeId = 3;

  @override
  AssetCountData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AssetCountData(
      counts: (fields[1] as List)?.cast<CountData>(),
      type: fields[2] as FilterType,
      subType: fields[3] as FilterSubType,
    );
  }

  @override
  void write(BinaryWriter writer, AssetCountData obj) {
    writer
      ..writeByte(3)
      ..writeByte(1)
      ..write(obj.counts)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.subType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AssetCountDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CountDataAdapter extends TypeAdapter<CountData> {
  @override
  final int typeId = 4;

  @override
  CountData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CountData(
      countOf: fields[1] as String,
      count: fields[2] as int,
      assetCount: fields[3] as int,
      faultCount: fields[4] as int,
      id: fields[5] as int,
      name: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CountData obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.countOf)
      ..writeByte(2)
      ..write(obj.count)
      ..writeByte(3)
      ..write(obj.assetCount)
      ..writeByte(4)
      ..write(obj.faultCount)
      ..writeByte(5)
      ..write(obj.id)
      ..writeByte(6)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CountDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
