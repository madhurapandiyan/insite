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
          .getGeofenceDataVL(Urls.postPayLoad, customer.CustomerUID);
      return Data;
    } else {
      Geofence Data = await MyApi().getClient().getGeofenceData(
          Urls.getGeofenceData, customer.CustomerUID, "in-geofence-gfapi");
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
    Customer customer = await _localService.getAccountInfo();
    if (isVisionLink) {
      dynamic data = await MyApi().getClientSeven().postGeofencePayLoadVL(
          Urls.postPayLoad, customer.CustomerUID, payload);
    } else {
      dynamic data = await MyApi().getClient().postGeofencePayLoad(
          Urls.getGeofenceData,
          customer.CustomerUID,
          payload,
          "in-geofence-gfapi");
    }
  }

  Future<dynamic> putGeofenceData(Geofencepayload payload) async {
    Logger().d(payload.toJson());
    Customer customer = await _localService.getAccountInfo();
    if (isVisionLink) {
      dynamic data = await MyApi().getClientSeven().putGeofencePayLoadVL(
          Urls.postPayLoad, customer.CustomerUID, payload);
    } else {
      dynamic data = await MyApi().getClient().putGeofencePayLoad(
          Urls.getGeofenceData,
          customer.CustomerUID,
          payload,
          "in-geofence-gfapi");
    }
  }

  Future<dynamic> putGeofenceDataWithMaterial(
      GeofenceModelWithMaterialData payload) async {
    Logger().d(payload.Input.toJson());
    Customer customer = await _localService.getAccountInfo();
    if (isVisionLink) {
      dynamic data = await MyApi().getClientSeven().putGeofenceAnotherData(
          Urls.withMaterialData, customer.CustomerUID, payload);
    } else {
      // dynamic data = await MyApi().getClient().postGeofencePayLoad(
      //     Urls.getGeofenceData,
      //     customer.CustomerUID,
      //     payload,
      //     "in-geofence-gfapi");
    }
  }

  Future<dynamic> postAddGeofenceData(Addgeofencemodel payload) async {
    print(payload.toJson());
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
        var data = MyApi().getClientSeven().deleteGeofenceVL(
            Urls.postPayLoad + FilterUtils.constructQueryFromMap(queryMap),
            customer.CustomerUID);
      } else {
        queryMap["geofenceuid"] = geofenceUID.toString();
        queryMap["actionutc"] = actionUTC.toString();
        var data = MyApi().getClient().deleteGeofence(
            Urls.getGeofenceData + FilterUtils.constructQueryFromMap(queryMap),
            customer.CustomerUID,
            "in-geofence-gfapi");
      }
    } catch (e) {
      Logger().e(toString());
    }
  }

  Future<Geofencemodeldata> getSingleGeofenceData(String uid) async {
    Customer customer = await _localService.getAccountInfo();
    Geofencemodeldata data;
    if (isVisionLink) {
      data = await MyApi().getClientSeven().getSingleGeofenceVL(
          Urls.postPayLoad + "/" + uid, customer.CustomerUID);
    } else {
      data = await MyApi().getClient().getSingleGeofence(
          Urls.getGeofenceData + "/" + uid,
          customer.CustomerUID,
          "in-geofence-gfapi");
    }
    return data;
  }

  Future<GetAddgeofenceModel> getGeofenceInput(String uid) async {
    Customer customer = await _localService.getAccountInfo();
    GetAddgeofenceModel geofenceInputsData;
    if (isVisionLink) {
      geofenceInputsData = await MyApi().getClientSeven().getGeofenceInputData(
          Urls.getGeofenceInputsUrl + uid + "/asgeofence",
          customer.CustomerUID);
      return geofenceInputsData;
    }
  }

  Future<Null> markFavourite(String uid, String favToggle) async {
    Customer customer = await _localService.getAccountInfo();
    String querryUrlVL = "geofenceUID=$uid";
    String querryUrl = "geofenceUIDs=$uid";
    Logger().w(favToggle);

    if (isVisionLink) {
      var data = await MyApi().getClientSeven().markFavouriteVL(
          Urls.postPayLoad + "/" + favToggle + querryUrlVL,
          customer.CustomerUID);
    } else {
      var data = await MyApi().getClient().markFavourite(
          Urls.getGeofenceData + "/" + favToggle + querryUrl,
          customer.CustomerUID,
          "in-geofence-gfapi");
    }
  }
}
