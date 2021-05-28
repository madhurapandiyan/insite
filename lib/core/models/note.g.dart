// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    userAssetNoteUID: json['userAssetNoteUID'] as String,
    assetUID: json['assetUID'] as String,
    userUID: json['userUID'] as String,
    userName: json['userName'] as String,
    assetUserNote: json['assetUserNote'] as String,
    lastModifiedUTC: json['lastModifiedUTC'] as String,
    enableDeleteButton: json['enableDeleteButton'] as bool,
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'userAssetNoteUID': instance.userAssetNoteUID,
      'assetUID': instance.assetUID,
      'userUID': instance.userUID,
      'userName': instance.userName,
      'assetUserNote': instance.assetUserNote,
      'lastModifiedUTC': instance.lastModifiedUTC,
      'enableDeleteButton': instance.enableDeleteButton,
    };

PostNote _$PostNoteFromJson(Map<String, dynamic> json) {
  return PostNote(
    assetUID: json['assetUID'] as String,
    assetUserNote: json['assetUserNote'] as String,
  );
}

Map<String, dynamic> _$PostNoteToJson(PostNote instance) => <String, dynamic>{
      'assetUID': instance.assetUID,
      'assetUserNote': instance.assetUserNote,
    };

PingPostDeviceData _$PingPostDeviceDataFromJson(Map<String, dynamic> json) {
  return PingPostDeviceData(
    AssetUID: json['AssetUID'] as String,
    DeviceUID: json['DeviceUID'] as String,
  );
}

Map<String, dynamic> _$PingPostDeviceDataToJson(PingPostDeviceData instance) =>
    <String, dynamic>{
      'AssetUID': instance.AssetUID,
      'DeviceUID': instance.DeviceUID,
    };

PingDeviceData _$PingDeviceDataFromJson(Map<String, dynamic> json) {
  return PingDeviceData(
    AssetUID: json['AssetUID'] as String,
    DeviceUID: json['DeviceUID'] as String,
    DevicePingLogUID: json['DevicePingLogUID'] as String,
    RequestExpiryTimeUTC: json['RequestExpiryTimeUTC'] as String,
    RequestState: json['RequestState'] as String,
    RequestStatusID: json['RequestStatusID'] as String,
    RequestTimeUTC: json['RequestTimeUTC'] as String,
  );
}

Map<String, dynamic> _$PingDeviceDataToJson(PingDeviceData instance) =>
    <String, dynamic>{
      'DeviceUID': instance.DeviceUID,
      'AssetUID': instance.AssetUID,
      'DevicePingLogUID': instance.DevicePingLogUID,
      'RequestStatusID': instance.RequestStatusID,
      'RequestState': instance.RequestState,
      'RequestTimeUTC': instance.RequestTimeUTC,
      'RequestExpiryTimeUTC': instance.RequestExpiryTimeUTC,
    };
