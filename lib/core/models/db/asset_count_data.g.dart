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
    );
  }

  @override
  void write(BinaryWriter writer, AssetCountData obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.counts)
      ..writeByte(2)
      ..write(obj.type);
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
    );
  }

  @override
  void write(BinaryWriter writer, CountData obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.countOf)
      ..writeByte(2)
      ..write(obj.count);
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
