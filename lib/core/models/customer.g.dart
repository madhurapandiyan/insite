// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CustomerAdapter extends TypeAdapter<Customer> {
  @override
  final int typeId = 5;

  @override
  Customer read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Customer(
      CustomerUID: fields[0] as String?,
      Name: fields[1] as String?,
      CustomerType: fields[2] as String?,
      Children: (fields[4] as List?)?.cast<Customer>(),
      DisplayName: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Customer obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.CustomerUID)
      ..writeByte(1)
      ..write(obj.Name)
      ..writeByte(2)
      ..write(obj.CustomerType)
      ..writeByte(3)
      ..write(obj.DisplayName)
      ..writeByte(4)
      ..write(obj.Children);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CustomerAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) => Customer(
      CustomerUID: json['CustomerUID'] as String?,
      Name: json['Name'] as String?,
      CustomerType: json['CustomerType'] as String?,
      Children: (json['Children'] as List<dynamic>?)
          ?.map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList(),
      DisplayName: json['DisplayName'] as String?,
    );

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'CustomerUID': instance.CustomerUID,
      'Name': instance.Name,
      'CustomerType': instance.CustomerType,
      'DisplayName': instance.DisplayName,
      'Children': instance.Children,
    };

CustomersResponse _$CustomersResponseFromJson(Map<String, dynamic> json) =>
    CustomersResponse(
      UserUID: json['UserUID']as String?,
      Customers: (json['Customers'] as List<dynamic>?)
          ?.map((e) => Customer.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CustomersResponseToJson(CustomersResponse instance) =>
    <String, dynamic>{
      'UserUID': instance.UserUID,
      'Customers': instance.Customers,
    };
