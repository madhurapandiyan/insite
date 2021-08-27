// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AccountDataAdapter extends TypeAdapter<AccountData> {
  @override
  final int typeId = 6;

  @override
  AccountData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AccountData(
      selectionType: fields[0] as AccountType,
      value: fields[1] as Customer,
      isSelected: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AccountData obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.selectionType)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.isSelected);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccountDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
