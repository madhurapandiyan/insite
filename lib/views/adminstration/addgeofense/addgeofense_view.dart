import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/address_custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/addgeofense/add_geofence_widget/location_search.dart/location_search_widget.dart';

import 'package:insite/views/adminstration/reusable_widget/dropdown.dart';

import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'add_geofence_widget/geofencing_map/geofencing_map.dart';

import 'addgeofense_view_model.dart';

class AddgeofenseView extends StatefulWidget {
  @override
  State<AddgeofenseView> createState() => _AddgeofenseViewState();
}

class _AddgeofenseViewState extends State<AddgeofenseView> {
  Color pickerColor = tango;
  Color currentColor;
  double lat = 30.666;
  double lon = 76.8127;
  var titleFocus = FocusNode();
  var descriptionFocus = FocusNode();
  var targetFocus = FocusNode();

  // DateTime backFillDate;
//  DateTime endDate;

  @override
  void initState() {
    super.initState();
  }

  void endDatePicker(AddgeofenseViewModel model) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2023))
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        model.endingDate = value;
      });
    });
  }

  void backFillDatePicker(AddgeofenseViewModel model) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        model.backFillDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    var theme = Theme.of(context);
    return ViewModelBuilder<AddgeofenseViewModel>.reactive(
      builder:
          (BuildContext context, AddgeofenseViewModel viewModel, Widget _) {
        //Logger().e(viewModel.materialdata);
        Logger().e(viewModel.endingDate);
        Logger().e(viewModel.backFillDate);
        return InsiteScaffold(
          viewModel: viewModel,
          body: viewModel.isLoading
              ? Center(
                  child: InsiteProgressBar(),
                )
              : SingleChildScrollView(
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
                              onTap: viewModel.onRespectivePageNavigation,
                              title: "MANAGE GEOFENCE",
                              height: mediaquerry.size.height * 0.05,
                              width: mediaquerry.size.width * 0.4,
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: mediaquerry.size.height * 0.55,
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: theme.cardColor,
                        ),
                        child: viewModel.isSearching
                            ? LocationSearchView(
                                getLatLong: (lat, long) {
                                  setState(() {
                                    viewModel.onLocationSelected(lat, long);
                                  });
                                },
                                onApply: (_) {
                                  setState(() {
                                    viewModel.isSearching =
                                        !viewModel.isSearching;
                                  });
                                },
                              )
                            : Stack(
                                alignment: Alignment.topRight,
                                children: [
                                  Container(
                                    height: mediaquerry.size.height * 0.6,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 2),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: theme.backgroundColor,
                                    ),
                                    child: GeofencingMap(
                                      completer: viewModel.googleMapController,
                                      camPosition: viewModel.centerPosition,
                                      color: currentColor,
                                      initialValue: viewModel.initialMapType,
                                      mapType: viewModel.mapType,
                                      isDrawing: viewModel.isDrawingPolygon,
                                      circle: viewModel.circle,
                                      polygon: viewModel.polygon,
                                      polyline: viewModel.polyline,
                                      gettingData: (LatLng latlng) {
                                        viewModel.onGettingLatLang(latlng);
                                      },
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InsiteButton(
                                                bgColor: tuna,
                                                title: "",
                                                onTap: () {
                                                  setState(() {
                                                    viewModel.zoomValue++;
                                                    viewModel.plus(
                                                        viewModel.zoomValue,
                                                        LatLng(lat++, lon++));
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.add,
                                                  color: appbarcolor,
                                                )),
                                            Dropdown(
                                              maptype: viewModel.mapType,
                                              changingvalue: (value) {
                                                setState(() {
                                                  viewModel.initialMapType =
                                                      value;
                                                });
                                              },
                                              initialvalue:
                                                  viewModel.initialMapType,
                                            ),
                                            InsiteButton(
                                                title: "",
                                                bgColor: viewModel.isSearching
                                                    ? tango
                                                    : tuna,
                                                onTap: () {
                                                  setState(() {
                                                    viewModel.isSearching =
                                                        !viewModel.isSearching;
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.search,
                                                  color: appbarcolor,
                                                )),
                                            InsiteButton(
                                                bgColor:
                                                    viewModel.isDrawingPolygon
                                                        ? tango
                                                        : tuna,
                                                title: "",
                                                onTap: viewModel
                                                        .polygon.isNotEmpty
                                                    ? null
                                                    : () {
                                                        Logger().e(
                                                            viewModel.polygon);
                                                        setState(() {
                                                          // Logger().e("xdgvzdx");
                                                          viewModel
                                                                  .isDrawingPolygon =
                                                              !viewModel
                                                                  .isDrawingPolygon;
                                                          viewModel.polygon
                                                              .clear();
                                                          viewModel.polyline
                                                              .clear();
                                                          viewModel.circle
                                                              .clear();
                                                          viewModel
                                                              .listOfLatLong
                                                              .clear();
                                                        });
                                                        Logger().e(
                                                            viewModel.polygon);
                                                        Logger().d(viewModel
                                                            .isDrawingPolygon);
                                                      },
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: appbarcolor,
                                                )),
                                          ],
                                        ),
                                        Container(
                                          padding: EdgeInsets.all(10),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InsiteButton(
                                                  title: "",
                                                  bgColor: tuna,
                                                  onTap: () {
                                                    setState(() {
                                                      viewModel.zoomValue--;
                                                      viewModel.minus(
                                                          viewModel.zoomValue,
                                                          LatLng(lat--, lon--));
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.minimize,
                                                    color: appbarcolor,
                                                  )),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InsiteButton(
                                                      bgColor: tuna,
                                                      title: "",
                                                      onTap: viewModel.polygon
                                                              .isNotEmpty
                                                          ? () => showDialog(
                                                              context: context,
                                                              builder: (ctx) =>
                                                                  AlertDialog(
                                                                    title: Text(
                                                                        "Clear Geofence"),
                                                                    content: Text(
                                                                        "Are you sure you want to clear this geofence?"),
                                                                    actions: [
                                                                      Row(
                                                                        children: [
                                                                          FlatButton.icon(
                                                                              onPressed: () => Navigator.of(context).pop(),
                                                                              icon: Icon(Icons.cancel),
                                                                              label: Text("cancel")),
                                                                          FlatButton.icon(
                                                                              onPressed: () {
                                                                                setState(() {
                                                                                  viewModel.listOfLatLong.clear();
                                                                                  viewModel.listOfNumber.clear();
                                                                                  viewModel.lastLatLong = null;
                                                                                  viewModel.listOfLatLong.clear();
                                                                                  viewModel.listOfNumber.clear();
                                                                                  viewModel.polygon.clear();
                                                                                  viewModel.polyline.clear();
                                                                                  viewModel.circle.clear();
                                                                                  viewModel.listOfLatLong.clear();
                                                                                  Navigator.of(context).pop();
                                                                                });
                                                                              },
                                                                              icon: Icon(Icons.delete),
                                                                              label: Text("Clear"))
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ))
                                                          : null,
                                                      icon: Icon(
                                                        Icons.delete,
                                                        color: appbarcolor,
                                                      )),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: InsiteButton(
                                                        bgColor: tuna,
                                                        title: "",
                                                        onTap: () => showDialog(
                                                            context: context,
                                                            builder:
                                                                (ctx) =>
                                                                    AlertDialog(
                                                                      actions: [
                                                                        FlatButton.icon(
                                                                            onPressed: () {
                                                                              setState(() {
                                                                                currentColor = pickerColor;
                                                                                viewModel.color = currentColor;
                                                                                Logger().d(viewModel.color);
                                                                                viewModel.onChoosingColor(currentColor.toString());
                                                                              });
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            icon: Icon(Icons.check),
                                                                            label: Text("Apply"))
                                                                      ],
                                                                      content:
                                                                          SingleChildScrollView(
                                                                        child: ColorPicker(
                                                                            pickerColor: pickerColor,
                                                                            onColorChanged: (color) {
                                                                              setState(() {
                                                                                pickerColor = color;
                                                                              });
                                                                            }),
                                                                      ),
                                                                    )),
                                                        icon: Icon(
                                                          Icons
                                                              .auto_awesome_mosaic,
                                                          color: currentColor,
                                                        )),
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
                      //formfield widget
                      // Formfieldwidget(
                      //   allowAccessToSecurity: viewModel.allowAccessToSecurity,
                      //   changecheckboxstate: viewModel.checkBoxState(),
                      //   dropdownlist: viewModel.dropDownlist,
                      //   filterdata: viewModel.filterOnChange,
                      //   getmaterialdata: viewModel.getMaterialData,
                      //   isNoendDate: viewModel.isNoendDate,
                      //   materialmodel: viewModel.materialModelList,
                      // )
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                  width: double.infinity,
                                  height: mediaquerry.size.height * 0.05,
                                  child: CustomTextBox(
                                    focusNode: titleFocus,
                                    title: "title",
                                    controller: viewModel.titleController,
                                  )),
                              Container(
                                padding: EdgeInsets.only(
                                  top: 15,
                                  bottom: 15,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Description :",
                                    ),
                                    Text(
                                      "Optional",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontStyle: FontStyle.italic,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                  width: double.infinity,
                                  child: AddressCustomTextBox(
                                    focusNode: descriptionFocus,
                                    title: "Description",
                                    controller: viewModel.descriptionController,
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: InsiteText(
                                  text: "Type :",
                                ),
                              ),
                              Container(
                                width: double.maxFinite,
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 1, color: Colors.white)),
                                child: CustomDropDownWidget(
                                  items: viewModel.dropDownlist,
                                  onChanged: (String value) {
                                    //widget.getmaterialdata();
                                    setState(() {
                                      viewModel.initialValue = value;
                                      viewModel.onChangeDropDown(value);
                                    });
                                  },
                                  value: viewModel.initialValue,
                                ),
                              ),
                              if (viewModel.initialValue ==
                                      viewModel.dropDownlist[2] ||
                                  viewModel.initialValue ==
                                      viewModel.dropDownlist[3] ||
                                  viewModel.initialValue ==
                                      viewModel.dropDownlist[4] ||
                                  viewModel.initialValue ==
                                      viewModel.dropDownlist[5] ||
                                  viewModel.initialValue ==
                                      viewModel.dropDownlist[6])
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InsiteText(
                                      text: "Material:",
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                      margin: EdgeInsets.all(2),
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 1, color: white),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Theme(
                                        data: Theme.of(context).copyWith(
                                            dividerColor: Colors.transparent),
                                        child: ExpansionTile(
                                          iconColor: white,
                                          onExpansionChanged: (bool) {},
                                          childrenPadding: EdgeInsets.all(10),
                                          title: InsiteText(
                                            text: viewModel.initialName,
                                          ),
                                          children: [
                                            Container(
                                              height: 450,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.all(20),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1,
                                                            color: white),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15)),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 8),
                                                      child: TextFormField(
                                                        autofocus: false,
                                                        onChanged: (value) {
                                                          setState(() {
                                                            viewModel
                                                                .materialSelection(
                                                                    value);
                                                          });
                                                        },
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                      child: Container(
                                                    child: ListView.builder(
                                                      itemCount: viewModel
                                                          .materialModelList
                                                          .length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int i) {
                                                        final data = viewModel
                                                            .materialModelList;
                                                        return ListTile(
                                                          onTap: () {
                                                            setState(() {
                                                              viewModel
                                                                      .initialName =
                                                                  data[i].name;
                                                              viewModel
                                                                  .materialUID = data[
                                                                      i]
                                                                  .materialUid;
                                                            });
                                                          },
                                                          title: InsiteText(
                                                            text: data[i].name,
                                                          ),
                                                          subtitle: InsiteText(
                                                            text: data[i]
                                                                .density
                                                                .toString(),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ))
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    InsiteText(
                                      text: "Target Estimated Volume:",
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Container(
                                        width: double.infinity,
                                        height: mediaquerry.size.height * 0.05,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: white),
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: TextFormField(
                                          focusNode: targetFocus,
                                          controller:
                                              viewModel.targetController,
                                          autofocus: false,
                                          style: TextStyle(color: white),
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              contentPadding: EdgeInsets.only(
                                                  left: 20, top: 10, bottom: 5),
                                              border: InputBorder.none,
                                              suffixIcon: Container(
                                                height:
                                                    mediaquerry.size.height *
                                                        0.05,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                            topRight: Radius
                                                                .circular(20),
                                                            bottomRight:
                                                                Radius.circular(
                                                                    20))),
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8,
                                                    horizontal: 20),
                                                child: InsiteText(
                                                  size: 20,
                                                  text: "cu.yd",
                                                ),
                                              )),
                                        )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InsiteText(
                                      text: "Backfill:",
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InsiteText(
                                      text:
                                          "Historic Cycle Counts will be associated to the geofence from this date",
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                        onTap: viewModel.isNoendDate
                                            ? null
                                            : () {
                                                backFillDatePicker(viewModel);
                                              },
                                        borderRadius: BorderRadius.circular(20),
                                        child: Container(
                                          width: double.infinity,
                                          height:
                                              mediaquerry.size.height * 0.05,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  width: 1,
                                                  color: Colors.white)),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InsiteText(
                                                  text:
                                                      "${viewModel.backFillDate == null || viewModel.isNoendDate ? "choose date" : DateFormat.yMMMd().format(viewModel.backFillDate)}",
                                                ),
                                                Icon(Icons
                                                    .calendar_today_outlined)
                                              ],
                                            ),
                                          ),
                                        )),
                                  ],
                                )
                              else
                                SizedBox(
                                  height: 10,
                                ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: InsiteText(
                                  text: "End Date :",
                                ),
                              ),
                              InkWell(
                                  onTap: viewModel.isNoendDate
                                      ? null
                                      : () {
                                          endDatePicker(viewModel);
                                        },
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: double.infinity,
                                    height: mediaquerry.size.height * 0.05,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            width: 1, color: Colors.white)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InsiteText(
                                            text:
                                                "${viewModel.endingDate == null ? "choose date" : DateFormat.yMMMd().format(viewModel.endingDate)}",
                                          ),
                                          Icon(Icons.calendar_today_outlined)
                                        ],
                                      ),
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 10),
                                child: InsiteText(
                                  size: 16,
                                  text:
                                      "Please select an end date or specify\nno end date",
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  setState(() {
                                    viewModel.isNoendDate =
                                        !viewModel.isNoendDate;

                                    viewModel.endingDate = null;
                                    viewModel.backFillDate = null;
                                  });
                                },
                                splashColor: Theme.of(context).backgroundColor,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              color: viewModel.isNoendDate
                                                  ? Theme.of(context)
                                                      .buttonColor
                                                  : Theme.of(context)
                                                      .backgroundColor,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(4))),
                                          child: Icon(
                                            Icons.crop_square,
                                            color: viewModel
                                                    .allowAccessToSecurity
                                                ? Theme.of(context).buttonColor
                                                : Colors.black,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: InsiteText(
                                        text: "No end date for this geofence",
                                        fontWeight: FontWeight.w700,
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    InsiteButton(
                                      height: mediaquerry.size.height * 0.05,
                                      width: mediaquerry.size.width * 0.4,
                                      bgColor:
                                          Theme.of(context).backgroundColor,
                                      title: "Cancel",
                                      fontSize: 20,
                                    ),
                                    InsiteButton(
                                      onTap: viewModel.correctedListofLatlang
                                                  .isEmpty &&
                                              viewModel
                                                  .titleController.text.isEmpty
                                          ? null
                                          : () {
                                              FocusScope.of(context).unfocus();
                                              Logger().e(viewModel
                                                  .titleController.text);
                                              viewModel.onSavingData();
                                            },
                                      height: mediaquerry.size.height * 0.05,
                                      width: mediaquerry.size.width * 0.4,
                                      title: "Save",
                                      fontSize: 20,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
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
