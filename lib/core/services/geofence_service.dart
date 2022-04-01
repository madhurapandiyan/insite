import 'package:insite/core/base/base_service.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/customer.dart';

import 'package:insite/core/repository/network.dart';
import 'package:insite/core/repository/network_graphql.dart';
import 'package:insite/core/services/local_service.dart';
import 'package:insite/utils/filter.dart';
import 'package:insite/utils/urls.dart';
import 'package:insite/views/adminstration/addgeofense/model/addgeofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencemodel.dart';
import 'package:insite/views/adminstration/addgeofense/model/geofencepayload.dart';
import 'package:insite/views/adminstration/addgeofense/model/materialmodel.dart';
import 'package:logger/logger.dart';

import 'graphql_schemas_service.dart';

class Geofenceservice extends BaseService {
  final LocalService? _localService = locator<LocalService>();
  GraphqlSchemaService? graphqlSchemaService = locator<GraphqlSchemaService>();
  Customer? accountSelected;
  Customer? customerSelected;

  setUp() async {
    try {
      accountSelected = await _localService!.getAccountInfo();
      customerSelected = await _localService!.getCustomerInfo();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<Geofence?> getGeofenceData() async {
    Customer? customer = await _localService!.getAccountInfo();

    if (enableGraphQl) {
      var data = await Network().getGraphqlData(
        query: graphqlSchemaService!.getGeofenceData(null, null),
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService?.getLoggedInUser())?.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      Geofence geofenceData = Geofence.fromJson(data.data["geofencesTypeId"]);
      Logger().w(geofenceData.toJson());
      return geofenceData;
    }
    if (isVisionLink) {
      Geofence Data = await MyApi()
          .getClientSeven()!
          .getGeofenceDataVL(Urls.postPayLoad, customer!.CustomerUID);
      return Data;
    } else {
      Geofence Data = await MyApi().getClient()!.getGeofenceData(
          Urls.getGeofenceData, customer!.CustomerUID, "in-geofence-gfapi");
      return Data;
    }
  }

  Future<Materialmodel> getMaterialModelData() async {
    Customer? customer = await _localService!.getAccountInfo();
    if (isVisionLink) {
      Materialmodel data = await MyApi()
          .getClientSeven()!
          .getMaterialModel(Urls.getMaterialData, customer!.CustomerUID);
      return data;
    } else {
      Materialmodel data = await MyApi()
          .getClientSeven()!
          .getMaterialModel(Urls.getMaterialData, customer!.CustomerUID);
      return data;
    }
  }

  Future<dynamic> postGeofenceData(
      Geofencepayload? payload, String query) async {
    Customer? customer = await _localService!.getAccountInfo();
    if (enableGraphQl) {
      print(query);

      var data = await Network().getGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService?.getLoggedInUser())?.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      return data;
    }
    if (isVisionLink) {
      dynamic data = await MyApi().getClientSeven()!.postGeofencePayLoadVL(
          Urls.postPayLoad, customer!.CustomerUID, payload!);
    } else {
      dynamic data = await MyApi().getClient()!.postGeofencePayLoad(
          Urls.getGeofenceData,
          customer!.CustomerUID,
          payload!,
          "in-geofence-gfapi");
    }
  }

  Future<dynamic> putGeofenceData(Geofencepayload payload, query) async {
    Logger().d(payload.toJson());
    Customer? customer = await _localService!.getAccountInfo();
    if (enableGraphQl) {
      print(query);
      var data = await Network().getGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService?.getLoggedInUser())?.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      return data;
    }
    if (isVisionLink) {
      dynamic data = await MyApi().getClientSeven()!.putGeofencePayLoadVL(
          Urls.postPayLoad, customer!.CustomerUID, payload);
    } else {
      dynamic data = await MyApi().getClient()!.putGeofencePayLoad(
          Urls.getGeofenceData,
          customer!.CustomerUID,
          payload,
          "in-geofence-gfapi");
    }
  }

  Future<dynamic> putGeofenceDataWithMaterial(
      GeofenceModelWithMaterialData payload, String query) async {
    Logger().d(payload.Input!.toJson());
    Customer? customer = await _localService!.getAccountInfo();
    if (enableGraphQl) {
      print(query);
      var data = await Network().getGraphqlData(
        query: query,
        customerId: accountSelected?.CustomerUID,
        userId: (await _localService?.getLoggedInUser())?.sub,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
      );
      return data;
    }
    if (isVisionLink) {
      dynamic data = await MyApi().getClientSeven()!.putGeofenceAnotherData(
          Urls.withMaterialData, customer!.CustomerUID, payload);
    } else {
      // dynamic data = await MyApi().getClient().postGeofencePayLoad(
      //     Urls.getGeofenceData,
      //     customer.CustomerUID,
      //     payload,
      //     "in-geofence-gfapi");
    }
  }

  Future<dynamic> postAddGeofenceData(
      Addgeofencemodel payload, String query) async {
    print(payload.toJson());
    Logger().d(payload.toJson());
    Customer? customer = await _localService!.getAccountInfo();
    if (enableGraphQl) {
      var data = await Network().getGraphqlData(
        customerId: accountSelected?.CustomerUID,
        query: query,
        subId: customerSelected?.CustomerUID == null
            ? ""
            : customerSelected?.CustomerUID,
        userId: (await _localService!.getLoggedInUser())!.sub,
      );
    }
    if (isVisionLink) {
      var data = await MyApi().getClientSeven()!.postGeofenceAnotherData(
          Urls.withMaterialData, customer!.CustomerUID, payload);
    } else {
      var data = await MyApi().getClientSeven()!.postGeofenceAnotherData(
          Urls.withMaterialData, customer!.CustomerUID, payload);
    }
  }

  Future<void> deleteGeofence(geofenceUID, actionUTC) async {
    try {
      Map<String, String> queryMap = Map();
      Customer? customer = await _localService!.getAccountInfo();
      if (enableGraphQl) {
        var data = await Network().getGraphqlData(
          customerId: accountSelected?.CustomerUID,
          query: graphqlSchemaService!.deleteGeofence(geofenceUID, actionUTC),
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
        );
        return;
      }
      if (isVisionLink) {
        queryMap["geofenceuid"] = geofenceUID.toString();
        queryMap["actionutc"] = actionUTC.toString();
        Logger().d(queryMap);
        Logger()
            .d(Urls.postPayLoad + FilterUtils.constructQueryFromMap(queryMap));
        var data = MyApi().getClientSeven()!.deleteGeofenceVL(
            Urls.postPayLoad + FilterUtils.constructQueryFromMap(queryMap),
            customer!.CustomerUID);
      } else {
        queryMap["geofenceuid"] = geofenceUID.toString();
        queryMap["actionutc"] = actionUTC.toString();
        var data = MyApi().getClient()!.deleteGeofence(
            Urls.getGeofenceData + FilterUtils.constructQueryFromMap(queryMap),
            customer!.CustomerUID,
            "in-geofence-gfapi");
      }
    } catch (e) {
      Logger().e(toString());
    }
  }

  Future<Geofencemodeldata> getSingleGeofenceData(String? uid) async {
    Customer? customer = await _localService!.getAccountInfo();
    Geofencemodeldata data;
    if (enableGraphQl) {
      var graphQlData = await Network().getGraphqlData(
          query: graphqlSchemaService!.geofenceSingleResponce(uid!),
          subId: customerSelected?.CustomerUID == null
              ? ""
              : customerSelected?.CustomerUID,
          userId: (await _localService!.getLoggedInUser())!.sub,
          customerId: accountSelected?.CustomerUID);
      data = Geofencemodeldata(
        AreaSqMeters: double.parse(
            graphQlData.data["geofenceSingleResponse"]["areaSqMeters"]),
        CustomerUID: graphQlData.data["geofenceSingleResponse"]["customerUID"],
        EndDate: graphQlData.data["geofenceSingleResponse"]["endDate"],
        Description: graphQlData.data["geofenceSingleResponse"]["description"],
        FillColor: graphQlData.data["geofenceSingleResponse"]["fillColor"],
        GeofenceName: graphQlData.data["geofenceSingleResponse"]
            ["geofenceName"],
        GeofenceType: graphQlData.data["geofenceSingleResponse"]
            ["geofenceType"],
        GeofenceUID: graphQlData.data["geofenceSingleResponse"]["geofenceUID"],
        GeometryWKT: graphQlData.data["geofenceSingleResponse"]["geometryWKT"],
        IsTransparent: graphQlData.data["geofenceSingleResponse"]
            ["isTransparent"],
        StartDate: graphQlData.data["geofenceSingleResponse"]["startDate"],
      );
      return data;
    }
    if (isVisionLink) {
      data = await MyApi().getClientSeven()!.getSingleGeofenceVL(
          Urls.postPayLoad + "/" + uid!, customer!.CustomerUID);
    } else {
      data = await MyApi().getClient()!.getSingleGeofence(
          Urls.getGeofenceData + "/" + uid!,
          customer!.CustomerUID,
          "in-geofence-gfapi");
    }
    return data;
  }

  Future<GetAddgeofenceModel> getGeofenceInput(String? uid) async {
    Customer? customer = await _localService!.getAccountInfo();
    GetAddgeofenceModel? geofenceInputsData;
    if (isVisionLink) {
      geofenceInputsData = await MyApi().getClientSeven()!.getGeofenceInputData(
          Urls.getGeofenceInputsUrl + uid! + "/asgeofence",
          customer!.CustomerUID);
    }
    return geofenceInputsData!;
  }

  Future<dynamic> markFavourite(
      String uid, String favToggle, bool isFav) async {
    Customer? customer = await _localService!.getAccountInfo();
    String querryUrlVL = "geofenceUID=$uid";
    String querryUrl = "geofenceUIDs=$uid";
    Logger().w(favToggle);
    if (enableGraphQl) {
      if (isFav) {
        var data = await Network().getGraphqlData(
            query: graphqlSchemaService!.markFav(uid),
            subId: customerSelected?.CustomerUID == null
                ? ""
                : customerSelected?.CustomerUID,
            userId: (await _localService!.getLoggedInUser())!.sub,
            customerId: accountSelected?.CustomerUID);
        return data;
      } else {
        var data = await Network().getGraphqlData(
            query: graphqlSchemaService!.markUnfav(uid),
            subId: customerSelected?.CustomerUID == null
                ? ""
                : customerSelected?.CustomerUID,
            userId: (await _localService!.getLoggedInUser())!.sub,
            customerId: accountSelected?.CustomerUID);
        return data;
      }
    }
    if (isVisionLink) {
      var data = await MyApi().getClientSeven()!.markFavouriteVL(
          Urls.postPayLoad + "/" + favToggle + querryUrlVL,
          customer!.CustomerUID);
    } else {
      var data = await MyApi().getClient()!.markFavourite(
          Urls.getGeofenceData + "/" + favToggle + querryUrl,
          customer!.CustomerUID,
          "in-geofence-gfapi");
    }
  }
}
