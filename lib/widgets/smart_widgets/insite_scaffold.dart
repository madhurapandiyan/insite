import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/appbar/appbar_view.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:insite/views/filter/filter_view.dart';
import 'package:insite/views/filter/refine.dart';
import 'package:insite/views/global_search/global_search_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked_services/stacked_services.dart'as service;
import 'package:insite/views/error/error_widget.dart' as error;

class InsiteScaffold extends StatefulWidget {
  final ScreenType? screenType;
  final Widget? body;
  final InsiteViewModel? viewModel;
  final VoidCallback? onFilterApplied;
  final VoidCallback? onRefineApplied;
  InsiteScaffold(
      {this.screenType,
      this.body,
      this.onRefineApplied,
      this.viewModel,
      this.onFilterApplied});

  @override
  _InsiteScaffoldState createState() => _InsiteScaffoldState();
}

class _InsiteScaffoldState extends State<InsiteScaffold> {
  bool _isSearchSelected = false;
  bool _isFilterSelected = false;
  bool _isRefineSelected = false;
  service.NavigationService? _navigationService = locator<service.NavigationService>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onBackPressed();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: InsiteAppBar(
          shouldShowAccount:
              widget.screenType == ScreenType.HOME ? true : false,
          shouldShowFilter: widget.screenType == ScreenType.FLEET ||
                  widget.screenType == ScreenType.ASSET_OPERATION ||
                  widget.screenType == ScreenType.UTILIZATION ||
                  widget.screenType == ScreenType.HEALTH ||
                  widget.screenType == ScreenType.LOCATION
              ? true
              : false,
          shouldShowLogout: widget.screenType == ScreenType.ACCOUNT ||
                  widget.screenType == ScreenType.HOME
              ? true
              : false,
          shouldShowSearch: widget.screenType == ScreenType.ACCOUNT ||
                  widget.screenType == ScreenType.ASSET_SETTINGS||
                  widget.screenType==ScreenType.ASSET_SETTINGS_FILTER
              ? false
              : true,
          screenType: widget.screenType,
          height: widget.screenType == ScreenType.FLEET ||
                  widget.screenType == ScreenType.ASSET_OPERATION ||
                  widget.screenType == ScreenType.UTILIZATION ||
                  widget.screenType == ScreenType.HOME ||
                  widget.screenType == ScreenType.HEALTH ||
                  widget.screenType == ScreenType.DASHBOARD ||
                  widget.screenType == ScreenType.LOCATION ||
                  widget.screenType == ScreenType.ADMINISTRATION
              ? 80
              : 56,
          shouldShowTitle: widget.screenType == ScreenType.FLEET ||
                  widget.screenType == ScreenType.ASSET_OPERATION ||
                  widget.screenType == ScreenType.UTILIZATION ||
                  widget.screenType == ScreenType.HOME ||
                  widget.screenType == ScreenType.HEALTH ||
                  widget.screenType == ScreenType.DASHBOARD ||
                  widget.screenType == ScreenType.LOCATION ||
                  widget.screenType == ScreenType.ADMINISTRATION
              ? true
              : false,
          shouldShowRefine: widget.screenType == ScreenType.FLEET ||
                  widget.screenType == ScreenType.ASSET_OPERATION ||
                  widget.screenType == ScreenType.UTILIZATION ||
                  widget.screenType == ScreenType.HEALTH ||
                  widget.screenType == ScreenType.LOCATION
              ? true
              : false,
          isRefineSelected: _isRefineSelected,
          isSearchSelected: _isSearchSelected,
          isFilterSelected: _isFilterSelected,
          onSearchTap: () {
            setState(() {
              _isFilterSelected = false;
              _isRefineSelected = false;
              _isSearchSelected = !_isSearchSelected;
            });
          },
          onFilterTap: () {
            setState(() {
              _isSearchSelected = false;
              _isRefineSelected = false;
              _isFilterSelected = !_isFilterSelected;
            });
          },
          onRefineTap: () {
            setState(() {
              _isSearchSelected = false;
              _isFilterSelected = false;
              _isRefineSelected = !_isRefineSelected;
            });
          },
        ),
        body: widget.viewModel!.youDontHavePermission
            ? error.ErrorWidget(
                title: "",
                onTap: (value) {
                  onErrorActionClicked(value, widget.viewModel);
                },
                path: "",
                showAction: true,
                description:
                    "You do not have access to this application, please contact your Administrator to get access",
              )
            : Stack(children: [
                widget.body!,
                _isSearchSelected
                    ? GlobalSearchView(
                        onSelected: (TopMatch value) {
                          onGlobalSearchItemSelected(value);
                        },
                      )
                    : SizedBox(),
                _isFilterSelected
                    ? FilterView(
                        onFilterApplied: (bool) {
                          onFilterApplied(bool);
                        },
                        screenType: widget.screenType,
                      )
                    : SizedBox(),
                _isRefineSelected
                    ? Refine(
                        onRefineApplied: (bool) {
                          onRefineApplied(bool);
                        },
                        screenType: widget.screenType,
                      )
                    : SizedBox()
              ]),
      ),
    );
  }

  onErrorActionClicked(ErrorAction action, InsiteViewModel? viewModel) {
    if (action == ErrorAction.LOGIN) {
      viewModel!.login();
    } else if (action == ErrorAction.LOGIN) {}
  }

  onFilterApplied(bool) {
    setState(() {
      _isFilterSelected = !_isFilterSelected;
    });
    if (bool) {
      widget.onFilterApplied!();
    }
  }

  onRefineApplied(bool) {
    setState(() {
      _isRefineSelected = !_isRefineSelected;
    });
    if (bool) {
      widget.onRefineApplied!();
    }
  }

  onGlobalSearchItemSelected(TopMatch match) {
    setState(() {
      _isSearchSelected = !_isSearchSelected;
    });
    _navigationService!.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
            index: 0,
            type: widget.screenType,
            fleet: Fleet(
                assetSerialNumber: match.serialNumber,
                assetId: match.assetID,
                assetIdentifier: match.assetUID)));
  }

  Future<bool> onBackPressed() {
    Logger().i("onBackPressed");
    if (_isSearchSelected) {
      setState(() {
        _isSearchSelected = !_isSearchSelected;
      });
    } else if (_isFilterSelected) {
      setState(() {
        _isFilterSelected = !_isFilterSelected;
      });
    } else if (_isRefineSelected) {
      setState(() {
        _isRefineSelected = !_isRefineSelected;
      });
    } else {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
