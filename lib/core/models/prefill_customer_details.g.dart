// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prefill_customer_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomerDetails _$CustomerDetailsFromJson(Map<String, dynamic> json) {
  return CustomerDetails(
    customerResult: json['result'] == null
        ? null
        : CustomerResult.fromJson(json['result'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CustomerDetailsToJson(CustomerDetails instance) =>
    <String, dynamic>{
      'result': instance.customerResult,
    };

CustomerResult _$CustomerResultFromJson(Map<String, dynamic> json) {
  return CustomerResult(
    customerData: json['Customer'] == null
        ? null
        : CustomerData.fromJson(json['Customer'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$CustomerResultToJson(CustomerResult instance) =>
    <String, dynamic>{
      'Customer': instance.customerData,
    };

CustomerData _$CustomerDataFromJson(Map<String, dynamic> json) {
  return CustomerData(
    name: json['Name'] as String,
    code: json['Code'] as String,
    email: json['Email'] as String,
  );
}

Map<String, dynamic> _$CustomerDataToJson(CustomerData instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Code': instance.code,
      'Email': instance.email,
    };
