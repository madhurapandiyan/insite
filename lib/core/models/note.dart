import 'package:json_annotation/json_annotation.dart';
part 'note.g.dart';

@JsonSerializable()
class Note {
  final String userAssetNoteUID;
  final String assetUID;
  final String userUID;
  final String userName;
  final String assetUserNote;
  final String lastModifiedUTC;
  final bool enableDeleteButton;

  Note(
      {this.userAssetNoteUID,
      this.assetUID,
      this.userUID,
      this.userName,
      this.assetUserNote,
      this.lastModifiedUTC,
      this.enableDeleteButton});

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);
}

@JsonSerializable()
class PostNote {
  final String assetUID;
  final String assetUserNote;

  PostNote({this.assetUID, this.assetUserNote});

  factory PostNote.fromJson(Map<String, dynamic> json) =>
      _$PostNoteFromJson(json);

  Map<String, dynamic> toJson() => _$PostNoteToJson(this);
}

@JsonSerializable()
class PingPostDeviceData {
  final String AssetUID;
  final String DeviceUID;

  PingPostDeviceData({this.AssetUID, this.DeviceUID});

  factory PingPostDeviceData.fromJson(Map<String, dynamic> json) =>
      _$PingPostDeviceDataFromJson(json);

  Map<String, dynamic> toJson() => _$PingPostDeviceDataToJson(this);
}

@JsonSerializable()
class PingDeviceData {
  final String DeviceUID;
  final String AssetUID;
  final String DevicePingLogUID;
  final String RequestStatusID;
  final String RequestState;
  final String RequestTimeUTC;
  final String RequestExpiryTimeUTC;

  PingDeviceData(
      {this.AssetUID,
      this.DeviceUID,
      this.DevicePingLogUID,
      this.RequestExpiryTimeUTC,
      this.RequestState,
      this.RequestStatusID,
      this.RequestTimeUTC});

  factory PingDeviceData.fromJson(Map<String, dynamic> json) =>
      _$PingDeviceDataFromJson(json);

  Map<String, dynamic> toJson() => _$PingDeviceDataToJson(this);
}
