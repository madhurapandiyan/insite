import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:insite/core/insite_data_provider.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/views/subscription/options/sub_registration/multiple_asset_transfer/multiple_asset_transfer_card.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'multiple_asset_transfer_view_model.dart';

class MultipleAssetTransferView extends StatefulWidget {
  @override
  _MultipleAssetTransferViewState createState() =>
      _MultipleAssetTransferViewState();
}

class _MultipleAssetTransferViewState extends State<MultipleAssetTransferView> {
  // @override
  // void initState() {
  //   super.initState();

  //   IsolateNameServer.registerPortWithName(
  //       MultipleAssetTransferViewModel().port.sendPort, 'downloader_send_port');
  //   MultipleAssetTransferViewModel().port.listen((dynamic data) {
  //     String? id = data[0];
  //     DownloadTaskStatus? status = data[1];
  //     int? progress = data[2];
  //     setState(() {});
  //   });

  //   FlutterDownloader.registerCallback(downloadCallback);
  // }

  // @override
  // void dispose() {
  //   IsolateNameServer.removePortNameMapping('downloader_send_port');
  //   super.dispose();
  // }

  // static void downloadCallback(
  //     String id, DownloadTaskStatus status, int progress) {
  //   final SendPort send =
  //       IsolateNameServer.lookupPortByName('downloader_send_port')!;
  //   send.send([id, status, progress]);
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MultipleAssetTransferViewModel>.reactive(
      builder: (BuildContext context, MultipleAssetTransferViewModel viewModel,
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
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 15.0),
                    child: InsiteText(
                      text: 'MULTIPLE ASSET TRANSFER',
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
                              height: MediaQuery.of(context).size.height * 0.02,
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
                              height: MediaQuery.of(context).size.height * 0.02,
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
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    viewModel.onUpload();
                                  },
                                  child: InsiteButton(
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
                                ),
                                SizedBox(
                                  width: 30,
                                ),
                                GestureDetector(
                                  onTap: () {
                                 //   viewModel.onSampleDownload();
                                  },
                                  child: InsiteButton(
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
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  viewModel.dataLoaded
                      ? Column(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: List.generate(
                            viewModel.assetValues.length,
                            (i) => MultipleAssetTransferCard(
                              transfer: viewModel.assetValues[i],
                            ),
                          ),
                        )
                      : SizedBox(),
                  viewModel.dataLoaded
                      ? GestureDetector(
                          onTap: () async {
                            String result = await viewModel
                                .subscriptionMultipleTransferRegistration();

                            if (result == "success") {
                              Utils.showToast(Utils.suceessRegistration);
                            }
                          },
                          child: Center(
                            child: InsiteButton(
                              width: 150,
                              title: 'Register',
                              icon: Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                              textColor: white,
                              margin: EdgeInsets.all(20),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              )),
        );
      },
      viewModelBuilder: () => MultipleAssetTransferViewModel(),
    );
  }
}
