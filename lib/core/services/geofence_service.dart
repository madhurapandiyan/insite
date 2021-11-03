import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';

import 'package:insite/core/repository/network.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/adminstration/addgeofense/model/addgeofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencepayload.dart';
import 'package:insite/views/adminstration/addgeofense/model/materialmodel.dart';
import 'package:logger/logger.dart';

class Geofenceservice extends BaseService {
  final _localService = locator<LocalService>();

  Future<Geofence> getGeofenceData() async {
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

  Future<Materialmodel> getMaterialModelData() async {
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
    Logger().d(payload.toJson());

    Logger().d(payload.toJson());
    Customer customer = await _localService.getAccountInfo();
    if (isVisionLink) {
      dynamic data = await MyApi()
          .getClientSeven()
          .postGeofencePayLoad(Urls.postPayLoad, customer.CustomerUID, payload);
    } else {
      Map<String, dynamic> data = await MyApi()
          .getClientSeven()
          .postGeofencePayLoad(Urls.postPayLoad, customer.CustomerUID, payload);
    }
  }

  Future<dynamic> postAddGeofenceData(Addgeofencemodel payload) async {
    Logger().d(payload.toJson());
    Customer customer = await _localService.getAccountInfo();
    if (isVisionLink) {
      var data = await MyApi().getClientSeven().postGeofenceAnotherData(
          Urls.withMaterialData, customer.CustomerUID, payload);
    } else {
      var data = await MyApi().getClientSeven().postGeofenceAnotherData(
          Urls.withMaterialData, customer.CustomerUID, payload);
    }
  }

  Future<void> deleteGeofence(geofenceUID, actionUTC) async {
    try {
      Map<String, String> queryMap = Map();
      Customer customer = await _localService.getAccountInfo();
      if (isVisionLink) {
        queryMap["geofenceuid"] = geofenceUID.toString();
        queryMap["actionutc"] = actionUTC.toString();
        Logger().d(queryMap);
        Logger()
            .d(Urls.postPayLoad + FilterUtils.constructQueryFromMap(queryMap));
        var data = MyApi().getClientSeven().deleteGeofence(
            Urls.postPayLoad + FilterUtils.constructQueryFromMap(queryMap),
            customer.CustomerUID);
      } else {
        queryMap["geofenceuid"] = geofenceUID.toString();
        queryMap["actionutc"] = actionUTC.toString();
        var data = MyApi().getClientSeven().deleteGeofence(
            Urls.postPayLoad + FilterUtils.constructQueryFromMap(queryMap),
            customer.CustomerUID);
      }
    } catch (e) {
      Logger().e(toString());
    }
  }
}
