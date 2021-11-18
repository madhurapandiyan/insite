// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saving_sms_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SavingSmsModel _$SavingSmsModelFromJson(Map<String, dynamic> json) {
  return SavingSmsModel(
    AssetSerial: json['AssetSerial'] as String,
    GPSDeviceID: json['GPSDeviceID'] as String,
    Language: json['Language'] as String,
    Mobile: json['Mobile'] as String,
    Model: json['Model'] as String,
    Name: json['Name'] as String,
    StartDate: json['StartDate'] as String,
    UserID: json['UserID'] as int,
    img: json['img'] as String,
  );
}

Map<String, dynamic> _$SavingSmsModelToJson(SavingSmsModel instance) =>
    <String, dynamic>{
      'AssetSerial': instance.AssetSerial,
      'Name': instance.Name,
      'Mobile': instance.Mobile,
      'Language': instance.Language,
      'GPSDeviceID': instance.GPSDeviceID,
      'StartDate': instance.StartDate,
      'Model': instance.Model,
      'img': instance.img,
      'UserID': instance.UserID,
    };

SavingSmsResponce _$SavingSmsResponceFromJson(Map<String, dynamic> json) {
  return SavingSmsResponce(
    AssetSerialNo: (json['AssetSerialNo'] as List)
        ?.map((e) => e == null
            ? null
            : SavingSmsModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    code: json['code'] as int,
    message: json['message'] as String,
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$SavingSmsResponceToJson(SavingSmsResponce instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
      'AssetSerialNo': instance.AssetSerialNo,
    };
