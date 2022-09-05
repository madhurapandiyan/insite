import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/subscription/options/sub_registration/single_asset_reg/single_asset_registration_view_model.dart';
import 'package:logger/logger.dart';

class ReusableAutocompleteSearchView extends StatefulWidget {
  final TextEditingController? reuseController;
  final List<String>? data;
  final String Function(String?)? validator;
  final Function(String)? onSelected;
  final Function(String)? onChanged;
  final Function? onTap;
  bool isEnabled;
  bool? formFieldType;
  FieldType? type;

  ReusableAutocompleteSearchView(
      {Key? key,
      this.reuseController,
      this.data,
      this.validator,
      this.onChanged,
      this.isEnabled = true,
      this.formFieldType,
      this.type,
      this.onSelected,
      this.onTap})
      : super(key: key);

  @override
  _ReusableAutocompleteSearchViewState createState() =>
      _ReusableAutocompleteSearchViewState();
}

class _ReusableAutocompleteSearchViewState
    extends State<ReusableAutocompleteSearchView> {
  List<String> dataValues = [];
  List<String> filteredValues = [];

  @override
  Widget build(BuildContext context) {
    return TypeAheadField(
      noItemsFoundBuilder: (_) {
        return SizedBox();
      },
      suggestionsCallback: (pattern) async {
        try {
          Completer<List<String>> completer = new Completer();
          Logger().w(pattern);
          if (pattern.isNotEmpty) {
            await widget.onChanged!(pattern);
            completer.complete(widget.data);
            return completer.future;
          } else {
            return [];
          }
        } catch (e) {
          Logger().e(e.toString());
          return [];
        }
      },
      itemBuilder: (context, suggestion) {
        var data = suggestion as String?;
        return ListTile(
          title: Text(data!),
        );
      },
      hideOnEmpty: true,
      hideSuggestionsOnKeyboardHide: false,
      keepSuggestionsOnSuggestionSelected: false,
      getImmediateSuggestions: true,
      onSuggestionSelected: (suggestion) {
        // if ((suggestion as LocationKey?) != null) {
        //   viewModel.onSelect(suggestion!.value as String);
        //   onSeletingSuggestion!(
        //       LatLng(suggestion.latitude!, suggestion.longitude!));
        // }
      },
      textFieldConfiguration: TextFieldConfiguration(
        cursorColor: addUserBgColor,
        controller: widget.reuseController,
        maxLines: 1,
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyText1!.color,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
            isDense: true,
            border: OutlineInputBorder(
                borderSide: BorderSide(color: black, width: 1)),
            fillColor: white),
      ),
    );
  }

  errorText(String text) {
    if (text.isEmpty) {
      return '*required';
    }
  }
}
