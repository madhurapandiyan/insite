// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return Customer(
    CustomerUID: json['CustomerUID'] as String,
    Name: json['Name'] as String,
    CustomerType: json['CustomerType'] as String,
    Children: json['Children'] as String,
    DisplayName: json['DisplayName'] as String,
  );
}

Map<String, dynamic> _$CustomerToJson(Customer instance) => <String, dynamic>{
      'CustomerUID': instance.CustomerUID,
      'Name': instance.Name,
      'CustomerType': instance.CustomerType,
      'DisplayName': instance.DisplayName,
      'Children': instance.Children,
    };

CustomersResponse _$CustomersResponseFromJson(Map<String, dynamic> json) {
  return CustomersResponse(
    userId: json['userId'] as String,
    customers: (json['customers'] as List)
        ?.map((e) =>
            e == null ? null : Customer.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CustomersResponseToJson(CustomersResponse instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'customers': instance.customers,
    };
