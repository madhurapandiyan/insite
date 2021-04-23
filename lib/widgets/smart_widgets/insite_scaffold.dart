import 'package:flutter/material.dart';
import 'package:insite/core/locator.dart';
import 'package:insite/core/models/fleet.dart';
import 'package:insite/core/models/search_data.dart';
import 'package:insite/core/router_constants.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/appbar/appvar_view.dart';
import 'package:insite/views/detail/asset_detail_view.dart';
import 'package:insite/views/global_search/global_search_view.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:stacked_services/stacked_services.dart';

class InsiteScaffold extends StatefulWidget {
  final ScreenType screenType;
  final Widget body;
  InsiteScaffold({this.screenType, this.body});

  @override
  _InsiteScaffoldState createState() => _InsiteScaffoldState();
}

class _InsiteScaffoldState extends State<InsiteScaffold> {
  bool _isSearchSelected = false;
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
          screenType: ScreenType.FLEET,
          height: 56,
          isSearchSelected: _isSearchSelected,
          onSearchTap: () {
            setState(() {
              _isSearchSelected = !_isSearchSelected;
            });
          },
        ),
        body: Stack(children: [
          widget.body,
          _isSearchSelected
              ? GlobalSearchView(
                  onSelected: (TopMatch value) {
                    onGlobalSearchItemSelected(value);
                  },
                )
              : SizedBox()
        ]),
      ),
    );
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
    } else {
      return Future.value(true);
    }
    return Future.value(false);
  }
}
