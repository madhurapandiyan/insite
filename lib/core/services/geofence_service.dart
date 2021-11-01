import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';

import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/adminstration/addgeofense/model/addgeofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencepayload.dart';
import 'package:insite/views/adminstration/addgeofense/model/materialmodel.dart';
import 'package:logger/logger.dart';

class Geofenceservice extends BaseService {
  final _localService = locator<LocalService>();

  Future<Geofence> getgeoencedata() async {
    Customer customer = await _localService.getAccountInfo();
    if (isVisionLink) {
      Geofence Data = await MyApi()
          .getClientSeven()
          .getGeofenceData(Urls.postPayLoad, customer.CustomerUID);
      return Data;
    } else {
      Geofence Data = await MyApi()
          .getClientSeven()
          .getGeofenceData(Urls.postPayLoad, customer.CustomerUID);
      return Data;
    }
  }

  Future<Materialmodel> getmaterialmodeldata() async {
    Customer customer = await _localService.getAccountInfo();
    if (isVisionLink) {
      Materialmodel data = await MyApi()
          .getClientSeven()
          .getMaterialModel(Urls.getMaterialData, customer.CustomerUID);
      return data;
    } else {
      Materialmodel data = await MyApi()
          .getClientSeven()
          .getMaterialModel(Urls.getMaterialData, customer.CustomerUID);
      return data;
    }
  }

  Future<dynamic> postGeofenceData(Geofencepayload payload) async {
    try {
      Logger().d(payload.toJson());
      Customer customer = await _localService.getAccountInfo();
      if (isVisionLink) {
        dynamic data = await MyApi().getClientSeven().postGeofencePayLoad(
            Urls.postPayLoad, customer.CustomerUID, payload);
      } else {
        Map<String, dynamic> data = await MyApi()
            .getClientSeven()
            .postGeofencePayLoad(
                Urls.postPayLoad, customer.CustomerUID, payload);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> postAddGeofenceData(Addgeofencemodel payload) async {
    try {
      print(payload.toJson());
      Customer customer = await _localService.getAccountInfo();
      if (isVisionLink) {
        var data = await MyApi().getClientSeven().postGeofenceAnotherData(
            Urls.withMaterialData, customer.CustomerUID, payload);
      } else {
        var data = await MyApi().getClientSeven().postGeofenceAnotherData(
            Urls.withMaterialData, customer.CustomerUID, payload);
      }
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  Future<dynamic> deleteGeofence(geofenceUID, actionUTC) {
    try {
      Logger().e(Urls.withMaterialData);
      if (isVisionLink) {
        var data = MyApi()
            .getClientSeven()
            .deleteGeofence(Urls.withMaterialData, geofenceUID, actionUTC);
        // return data;
      } else {
        var data = MyApi()
            .getClientSeven()
            .deleteGeofence(Urls.withMaterialData, geofenceUID, actionUTC);
      }
    } catch (e) {
      Logger().e(toString());
    }
  }
}
