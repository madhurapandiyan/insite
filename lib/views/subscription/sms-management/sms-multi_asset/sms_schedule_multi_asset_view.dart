import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/subscription/sms-management/sms-single_asset/single_asset_validate_widget/single_asset_validate_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'sms_schedule_multi_asset_view_model.dart';

class SmsScheduleMultiAssetView extends StatefulWidget {
  @override
  _SmsScheduleMultiAssetViewState createState() =>
      _SmsScheduleMultiAssetViewState();
}

class _SmsScheduleMultiAssetViewState extends State<SmsScheduleMultiAssetView> {
  @override
  void initState() {
    super.initState();

    IsolateNameServer.registerPortWithName(
        SmsScheduleMultiAssetViewModel().port.sendPort, 'downloader_send_port');
    SmsScheduleMultiAssetViewModel().port.listen((dynamic data) {
      String? id = data[0];
      DownloadTaskStatus? status = data[1];
      int? progress = data[2];
      setState(() {});
    });

    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    super.dispose();
  }

  static void downloadCallback(
      String id, DownloadTaskStatus status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SmsScheduleMultiAssetViewModel>.reactive(
      builder: (BuildContext context, SmsScheduleMultiAssetViewModel viewModel,
          Widget? _) {
        return InsiteInheritedDataProvider(
          count: viewModel.appliedFilters!.length,
          child: InsiteScaffold(
              viewModel: viewModel,
              onFilterApplied: () {
                //viewModel.refresh();
              },
              onRefineApplied: () {
                //viewModel.refresh();
              },
              body: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 15.0),
                      child: InsiteText(
                        text: 'SMS SCHEDULE FOR MUTLIPLE ASSET',
                        size: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.25,
                      width: MediaQuery.of(context).size.width,
                      color: Theme.of(context).cardColor,
                      child: Row(
                        children: [
                          Container(
                            height: double.infinity,
                            width: MediaQuery.of(context).size.width * 0.02,
                            color: Theme.of(context).buttonColor,
                          ),
                          SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Expanded(
                                  child: InsiteText(
                                    text:
                                        'Register Multiple assets by uploading an MS EXCEL File from here',
                                    size: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.02,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Expanded(
                                  child: InsiteText(
                                    text:
                                        ' Note : Please click Sample Format to get the required format to upload',
                                    size: 14,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InsiteButton(
                                    onTap: () {
                                      viewModel.onUpload();
                                    },
                                    title: 'UPLOAD',
                                    icon: Icon(
                                      Icons.upload,
                                      color: white,
                                    ),
                                    textColor: white,
                                    bgColor: Theme.of(context).buttonColor,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.065,
                                  ),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  InsiteButton(
                                    onTap: () {
                                      viewModel.onSampleDownload();
                                    },
                                    title: 'SAMPLE FORMAT',
                                    icon: Icon(
                                      Icons.download,
                                      color: white,
                                    ),
                                    textColor: white,
                                    bgColor: Theme.of(context).buttonColor,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.065,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(

                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                            viewModel.singleAssetModelResponce!.length,
                            (i) => SingleAssetValidateWidget(
                                  GPSDeviceID: viewModel
                                      .singleAssetModelResponce![i].GPSDeviceID,
                                  SerialNumber: viewModel
                                      .singleAssetModelResponce![i]
                                      .SerialNumber,
                                  StartDate: viewModel
                                      .singleAssetModelResponce![i].StartDate,
                                  langugae: viewModel.languageList[i],
                                  model: viewModel
                                      .singleAssetModelResponce![i].Model,
                                  modileNo: viewModel.mobileNoList[i],
                                  name: viewModel.nameList[i],
                                ))),
                    viewModel.singleAssetModelResponce!.isEmpty
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                InsiteButton(
                                  fontSize: 14,
                                  onTap: () {
                                    viewModel.onBackPressed();
                                  },
                                  bgColor: tuna,
                                  title: "Back",
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.height *
                                      0.065,
                                ),
                                InsiteButton(
                                  fontSize: 14,
                                  onTap: () {
                                    viewModel.onSavingSmsModel().then((value) {
                                      Logger().wtf(value);
                                      if (value!) {
                                        return showDialog(
                                            context: context,
                                            builder: (ctx) => alertBox(
                                                  content:
                                                      "Moblie number Updated successfully!!!.",
                                                  isShowingButton: value,
                                                  onBackPress: () {
                                                    Navigator.of(context).pop();
                                                    viewModel.onBackPressed();
                                                  },
                                                ));
                                      } else {
                                        return showDialog(
                                            context: context,
                                            builder: (ctx) => alertBox(
                                                content:
                                                    "Serial number, Mobile number, Language and Recipient’s Name combination is already exists. Do you want to download?",
                                                isShowingButton: value,
                                                onNegativeButtonPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                onPositiveButtonPressed: () {
                                                  viewModel
                                                      .onDownloadingExcelSheet();
                                                }));
                                      }
                                    });
                                  },
                                  bgColor: tango,
                                  title: "Next",
                                  width:
                                      MediaQuery.of(context).size.width * 0.4,
                                  height: MediaQuery.of(context).size.height *
                                      0.065,
                                ),
                              ],
                            ),
                          )
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => SmsScheduleMultiAssetViewModel(),
    );
  }

  Widget alertBox(
      {Function? onBackPress,
      String? content,
      bool? isShowingButton,
      Function? onNegativeButtonPressed,
      Function? onPositiveButtonPressed}) {
    return AlertDialog(
      backgroundColor: tuna,
      actions: [
        isShowingButton!
            ? FlatButton.icon(
                onPressed: () {
                  onBackPress!();
                },
                icon: Icon(
                  Icons.done,
                  color: white,
                ),
                label: InsiteText(
                  text: "Okay",
                ))
            : Row(
                children: [
                  FlatButton.icon(
                      onPressed: () {
                        onPositiveButtonPressed!();
                      },
                      icon: Icon(
                        Icons.done,
                        color: white,
                      ),
                      label: InsiteText(
                        text: "Yes",
                      )),
                  FlatButton.icon(
                      onPressed: () {
                        onNegativeButtonPressed!();
                      },
                      icon: Icon(
                        Icons.done,
                        color: white,
                      ),
                      label: InsiteText(
                        text: "No",
                      ))
                ],
              )
      ],
      content: InsiteText(text: content
          //"Moblie number Updated successfully!!!.",
          ),
    );
  }
}
