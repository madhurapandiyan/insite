import 'package:flutter/material.dart';
import 'package:insite/core/base/insite_view_model.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/appbar/appvar_view.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:insite/views/filter/filter_view.dart';
import 'package:insite/views/global_search/global_search_view.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:insite/views/error/error_widget.dart' as error;

class InsiteScaffold extends StatefulWidget {
  final ScreenType screenType;
  final Widget body;
  final InsiteViewModel viewModel;
  final VoidCallback onFilterApplied;
  InsiteScaffold(
      {this.screenType, this.body, this.viewModel, this.onFilterApplied});

  @override
  _InsiteScaffoldState createState() => _InsiteScaffoldState();
}

class _InsiteScaffoldState extends State<InsiteScaffold> {
  bool _isSearchSelected = false;
  bool _isFilterSelected = false;
  var _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return onBackPressed();
      },
      child: Scaffold(
        backgroundColor: bgcolor,
        appBar: InsiteAppBar(
          shouldShowAccount:
              widget.screenType == ScreenType.DASHBOARD ? true : false,
          shouldShowFilter: widget.screenType == ScreenType.FLEET ||
                  widget.screenType == ScreenType.LOCATION
              ? true
              : false,
          shouldShowLogout: widget.screenType == ScreenType.ACCOUNT ||
                  widget.screenType == ScreenType.DASHBOARD
              ? true
              : false,
          shouldShowSearch:
              widget.screenType == ScreenType.ACCOUNT ? false : true,
          screenType: widget.screenType,
          height: 56,
          isSearchSelected: _isSearchSelected,
          isFilterSelected: _isFilterSelected,
          onSearchTap: () {
            setState(() {
              _isFilterSelected = false;
              _isSearchSelected = !_isSearchSelected;
            });
          },
          onFilterTap: () {
            setState(() {
              _isSearchSelected = false;
              _isFilterSelected = !_isFilterSelected;
            });
          },
        ),
        body: widget.viewModel.youDontHavePermission
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
                widget.body,
                _isSearchSelected
                    ? GlobalSearchView(
                        onSelected: (TopMatch value) {
                          onGlobalSearchItemSelected(value);
                        },
                      )
                    : SizedBox(),
                _isFilterSelected
                    ? FilterView(
                        onFilterApplied: () {
                          onFilterApplied();
                        },
                      )
                    : SizedBox()
              ]),
      ),
    );
  }

  onErrorActionClicked(error.ErrorAction action, InsiteViewModel viewModel) {
    if (action == error.ErrorAction.LOGIN) {
      viewModel.login();
    } else if (action == error.ErrorAction.LOGIN) {}
  }

  onFilterApplied() {
    setState(() {
      _isFilterSelected = !_isFilterSelected;
    });
    widget.onFilterApplied();
  }

  onGlobalSearchItemSelected(TopMatch match) {
    setState(() {
      _isSearchSelected = !_isSearchSelected;
    });
    _navigationService.navigateTo(assetDetailViewRoute,
        arguments: DetailArguments(
            fleet: Fleet(
                assetSerialNumber: match.serialNumber,
                assetId: match.assetID,
                assetIdentifier: match.assetUID)));
  }

  Future<bool> onBackPressed() {
    if (_isSearchSelected) {
      setState(() {
        _isSearchSelected = !_isSearchSelected;
      });
    } else if (_isFilterSelected) {
      setState(() {
        _isFilterSelected = !_isFilterSelected;
      });
    } else {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
