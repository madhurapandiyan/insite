import 'package:flutter/material.dart';

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
    return Autocomplete(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return Iterable<String>.empty();
        } else {
          widget.data!.map((e) {
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
        return Container(
          height: 35,
          child: TextFormField(
            onTap: widget.onTap as void Function()?,
            controller:
                widget.formFieldType == null || widget.formFieldType == true
                    ? widget.reuseController
                    : controller,
            focusNode: focusNode,
            cursorColor: addUserBgColor,
            validator: widget.validator,
            onChanged: widget.onChanged,
            maxLines: 1,
            enabled: widget.isEnabled,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodyText1!.color,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          //  onEditingComplete: onEditingComplete,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: 12, top: 22),
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).textTheme.bodyText1!.color!,
                    width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).textTheme.bodyText1!.color!,
                    width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                    color: Theme.of(context).textTheme.bodyText1!.color!,
                    width: 1),
              ),
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
