import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:google_maps_controller/google_maps_controller.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/address_custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';

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
  DateTime backFillDate;
  DateTime endDate;

  @override
  void initState() {
    super.initState();
  }

  void endDatePicker() {
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
        endDate = value;
      });
    });
  }

  void backFillDatePicker() {
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
        backFillDate = value;
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
                              onTap: () {},
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
                        child: Stack(
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      InsiteButton(
                                          bgColor: tuna,
                                          title: "",
                                          onTap: () {},
                                          icon: Icon(
                                            Icons.add,
                                            color: appbarcolor,
                                          )),
                                      Dropdown(
                                        maptype: viewModel.mapType,
                                        changingvalue: (value) {
                                          setState(() {
                                            viewModel.initialMapType = value;
                                          });
                                        },
                                        initialvalue: viewModel.initialMapType,
                                      ),
                                      InsiteButton(
                                          title: "",
                                          bgColor: tuna,
                                          onTap: () {},
                                          icon: Icon(
                                            Icons.search,
                                            color: appbarcolor,
                                          )),
                                      InsiteButton(
                                          bgColor: viewModel.isDrawingPolygon
                                              ? tango
                                              : tuna,
                                          title: "",
                                          onTap: viewModel.polygon.isNotEmpty
                                              ? null
                                              : () {
                                                  Logger().e(viewModel.polygon);
                                                  setState(() {
                                                    // Logger().e("xdgvzdx");
                                                    viewModel.isDrawingPolygon =
                                                        !viewModel
                                                            .isDrawingPolygon;
                                                    viewModel.polygon.clear();
                                                    viewModel.polyline.clear();
                                                    viewModel.circle.clear();
                                                    viewModel.listOfLatLong
                                                        .clear();
                                                  });
                                                  Logger().e(viewModel.polygon);
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
                                        InkWell(
                                            onTap: () {
                                              setState(() {
                                                //viewModel.onZoomOut();
                                              });
                                            },
                                            child: InsiteButton(
                                                title: "",
                                                bgColor: tuna,
                                                onTap: () {},
                                                icon: Icon(
                                                  Icons.minimize,
                                                  color: appbarcolor,
                                                ))),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            InsiteButton(
                                                bgColor: tuna,
                                                title: "",
                                                onTap:
                                                    viewModel.polygon.isNotEmpty
                                                        ? () => showDialog(
                                                            context: context,
                                                            builder:
                                                                (ctx) =>
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
                                              padding: const EdgeInsets.only(
                                                  top: 10),
                                              child: InsiteButton(
                                                  bgColor: tuna,
                                                  title: "",
                                                  onTap: () => showDialog(
                                                      context: context,
                                                      builder:
                                                          (ctx) => AlertDialog(
                                                                actions: [
                                                                  FlatButton.icon(
                                                                      onPressed: () {
                                                                        setState(
                                                                            () {
                                                                          currentColor =
                                                                              pickerColor;
                                                                          viewModel.color =
                                                                              currentColor;
                                                                        });
                                                                        Navigator.of(context)
                                                                            .pop();
                                                                      },
                                                                      icon: Icon(Icons.check),
                                                                      label: Text("Apply"))
                                                                ],
                                                                content:
                                                                    SingleChildScrollView(
                                                                  child:
                                                                      ColorPicker(
                                                                          pickerColor:
                                                                              pickerColor,
                                                                          onColorChanged:
                                                                              (color) {
                                                                            setState(() {
                                                                              pickerColor = color;
                                                                            });
                                                                          }),
                                                                ),
                                                              )),
                                                  icon: Icon(
                                                    Icons.auto_awesome_mosaic,
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
                                            : backFillDatePicker,
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
                                                      "${backFillDate == null || viewModel.isNoendDate ? "choose date" : DateFormat.yMMMd().format(backFillDate)}",
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
                                      : endDatePicker,
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
                                                "${endDate == null ? "choose date" : DateFormat.yMMMd().format(endDate)}",
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

                                    endDate = null;
                                    backFillDate = null;
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
                                      onTap: () {
                                        Logger()
                                            .e(viewModel.titleController.text);
                                        try {
                                          viewModel.onSavingData();
                                        } catch (e) {
                                          Logger().e(e.toString());
                                        }
                                        viewModel.endingDate = endDate;
                                        viewModel.backFillDate = backFillDate;
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
