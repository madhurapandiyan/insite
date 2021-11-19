import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';

import 'reusable_autocomplete_search_view_model.dart';

class ReusableAutocompleteSearchView extends StatefulWidget {
  final TextEditingController reuseController;
  final List<String> data;
  final String Function(String) validator;
  final Function(String) onSelected;
  final Function(String) onChanged;

  ReusableAutocompleteSearchView(
      {Key key,
      this.reuseController,
      this.data,
      this.validator,
      this.onChanged,
      this.onSelected})
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
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return Iterable<String>.empty();
        } else {
          widget.data.map((e) {
            dataValues.add(e);
          }).toList();

          dataValues.forEach((element) {
            if (element
                .toLowerCase()
                .contains(textEditingValue.text.toLowerCase())) {
              filteredValues.add(element);
            }
          });

          return filteredValues;
        }
      },
      onSelected: widget.onSelected,
      fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
        return TextField(
          controller: controller,
          focusNode: focusNode,
          cursorColor: addUserBgColor,
          // validator: widget.validator,
          onChanged: widget.onChanged,
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontWeight: FontWeight.w700,
            fontSize: 14,
          ),
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            // errorText: errorText(widget.reuseController.text),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).textTheme.bodyText1.color, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).textTheme.bodyText1.color, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                  color: Theme.of(context).textTheme.bodyText1.color, width: 1),
            ),
          ),
        );
      },
    );
  }

  errorText(String text) {
    if (text.isEmpty) {
      return '*required';
    }
  }
}
