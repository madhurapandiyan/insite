import 'dart:async';
import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/adminstration/addgeofense/add_geofence_widget/geofencing_map/geofencing_map.dart';

import 'package:insite/views/adminstration/reusable_widget/dropdown.dart';
import 'package:insite/views/adminstration/reusable_widget/reusabletapbutton.dart';

import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'add_geofence_widget/formfield.dart/formfieldwidget.dart';
import 'addgeofense_view_model.dart';
import 'dart:math' as Math;

class AddgeofenseView extends StatefulWidget {
  @override
  State<AddgeofenseView> createState() => _AddgeofenseViewState();
}

class _AddgeofenseViewState extends State<AddgeofenseView> {
  Color pickerColor = Colors.amber;
  Color currentcolor = Colors.red;
  bool istap;

  Widget tapbutton(IconData ico, Color color) {
    return Container(
      alignment: Alignment.center,
      width: 40,
      height: 40,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        color: color,
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: color)],
        border: Border.all(width: 2.5, color: color),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
          child: ico == Icons.minimize_rounded
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Icon(ico),
                )
              : Icon(
                  ico,
                  color: ico == Icons.auto_awesome_mosaic_rounded
                      ? currentcolor
                      : null,
                )),
    );
  }

  String initialmaptype = "MAP";
  changevalue(String userpicked) {
    initialmaptype = userpicked;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    var theme = Theme.of(context);
    return ViewModelBuilder<AddgeofenseViewModel>.reactive(
      builder:
          (BuildContext context, AddgeofenseViewModel viewModel, Widget _) {
        istap = viewModel.isdrawingpolygon;
        Logger().e(istap);
        return InsiteScaffold(
          onFilterApplied: () {},
          viewModel: viewModel,
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InsiteText(
                        text: "Add Geofence",
                        fontWeight: FontWeight.w700,
                        size: 20,
                      ),
                      InsiteButton(
                        title: "MANAGE GEOFENCE",
                        height: mediaquerry.size.height * 0.05,
                        width: mediaquerry.size.width * 0.4,
                      )
                    ],
                  ),
                ),
                Container(
                  height: mediaquerry.size.height * 0.55,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: theme.cardColor,
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: mediaquerry.size.height * 0.6,
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: theme.backgroundColor,
                        ),
                        child: GeofencingMap(viewModel, currentcolor,
                            initialmaptype, viewModel.zoomval),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                    onTap: () {
                                      setState(() {
                                        viewModel.onzooming();
                                      });
                                    },
                                    child: tapbutton(Icons.add, tuna)),
                                Dropdown(viewModel.maptype, initialmaptype,
                                    changevalue),
                                tapbutton(Icons.search, tuna),
                                InkWell(
                                  onTap: viewModel.polygon.isNotEmpty
                                      ? null
                                      : () {
                                          Logger().e(viewModel.polygon);
                                          setState(() {
                                            viewModel.isdrawingpolygon =
                                                !viewModel.isdrawingpolygon;
                                            viewModel.polygon.clear();
                                            viewModel.polylines.clear();
                                            viewModel.circle.clear();
                                            viewModel.listoflatlang.clear();
                                          });
                                          Logger().e(viewModel.polygon);
                                          Logger()
                                              .d(viewModel.isdrawingpolygon);
                                        },
                                  child: tapbutton(
                                      Icons.edit,
                                      viewModel.isdrawingpolygon
                                          ? tango
                                          : tuna),
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          viewModel.onzoomout();
                                        });
                                      },
                                      child: tapbutton(
                                          Icons.minimize_rounded, tuna)),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InkWell(
                                        onTap: viewModel.polygon.isNotEmpty
                                            ? () => showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                      title: Text(
                                                          "Clear Geofence"),
                                                      content: Text(
                                                          "Are you sure you want to clear this geofence?"),
                                                      actions: [
                                                        Row(
                                                          children: [
                                                            FlatButton.icon(
                                                                onPressed: () =>
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop(),
                                                                icon: Icon(Icons
                                                                    .cancel),
                                                                label: Text(
                                                                    "cancel")),
                                                            FlatButton.icon(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    viewModel
                                                                        .polygon
                                                                        .clear();
                                                                    viewModel
                                                                        .polyline
                                                                        .clear();
                                                                    viewModel
                                                                        .circle
                                                                        .clear();
                                                                    viewModel
                                                                        .listoflatlang
                                                                        .clear();
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  });
                                                                },
                                                                icon: Icon(Icons
                                                                    .delete),
                                                                label: Text(
                                                                    "Clear"))
                                                          ],
                                                        )
                                                      ],
                                                    ))
                                            : null,
                                        child: tapbutton(Icons.delete, tuna),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: InkWell(
                                          onTap: () => showDialog(
                                              context: context,
                                              builder: (ctx) => AlertDialog(
                                                    actions: [
                                                      FlatButton.icon(
                                                          onPressed: () {
                                                            setState(() {
                                                              currentcolor =
                                                                  pickerColor;
                                                              viewModel.color =
                                                                  currentcolor;
                                                            });
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          icon:
                                                              Icon(Icons.check),
                                                          label: Text("Apply"))
                                                    ],
                                                    content:
                                                        SingleChildScrollView(
                                                      child: ColorPicker(
                                                          pickerColor:
                                                              pickerColor,
                                                          onColorChanged:
                                                              (color) {
                                                            setState(() {
                                                              pickerColor =
                                                                  color;
                                                            });
                                                          }),
                                                    ),
                                                  )),
                                          child: tapbutton(
                                              Icons.auto_awesome_mosaic_rounded,
                                              tuna),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Formfieldwidget(
                      viewModel.dropDownlist,
                      viewModel.value,
                      viewModel.setDefaultPreferenceToUser,
                      viewModel.allowAccessToSecurity,
                      viewModel.changecheckboxstate),
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => AddgeofenseViewModel(),
    );
  }
}
