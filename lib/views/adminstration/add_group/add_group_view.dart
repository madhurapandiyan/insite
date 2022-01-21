import 'package:flutter/material.dart';
import 'package:insite/core/models/asset_group_summary_response.dart';
import 'package:insite/core/models/manage_group_summary_response.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/views/add_new_user/reusable_widget/address_custom_text_box.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_text_box.dart';
import 'package:insite/views/adminstration/add_group/selection_widget/selection_widget_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'add_group_view_model.dart';

class AddGroupView extends StatefulWidget {
  final Groups? groups;
  final bool? isEdit;

  AddGroupView({this.groups, this.isEdit});
  @override
  _AddGroupViewState createState() => _AddGroupViewState();
}

class _AddGroupViewState extends State<AddGroupView> {
  Groups? groups;
  @override
  Widget build(BuildContext context) {
    groups = ModalRoute.of(context)!.settings.arguments as Groups?;
    return ViewModelBuilder<AddGroupViewModel>.reactive(
      builder: (BuildContext context, AddGroupViewModel viewModel, Widget? _) {
        return InsiteScaffold(
            viewModel: viewModel,
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        groups != null
                            ? InsiteText(
                                text: "Edit Group",
                                fontWeight: FontWeight.w700,
                                size: 14,
                              )
                            : InsiteText(
                                text: "Add New Group",
                                fontWeight: FontWeight.w700,
                                size: 14,
                              ),
                        // Padding(
                        //   padding: EdgeInsets.only(right: 15.0),
                        //   child: InsiteButton(
                        //     title: 'manage groups'.toUpperCase(),
                        //     fontSize: 14,
                        //     onTap: () {},
                        //     textColor: Colors.white,
                        //   ),
                        // )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        // width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.05,
                        child: CustomTextBox(
                            title: "Name",
                            controller: viewModel.nameController)),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InsiteText(
                          text: "Description :",
                          fontWeight: FontWeight.w700,
                          size: 14,
                        ),
                        InsiteText(
                          text: "Optional",
                          fontWeight: FontWeight.w700,
                          size: 14,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    AddressCustomTextBox(
                      title: "Enter",
                      controller: viewModel.descriptionController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    SelectionWidgetView(
                      isEdit: widget.isEdit!,
                      assetIds: viewModel.assetUidData,
                      group: viewModel.groups,
                      dissociatedIds: viewModel.dissociatedAssetId,
                      onAssetSelected: (
                        List<String> value,
                        AssetGroupSummaryResponse data,
                        List<String> associatedAssetId,
                      ) {
                        viewModel.assetUidData = value;
                        viewModel.groupSummaryResponseData = data;
                        viewModel.associatedAssetId = associatedAssetId;
                      },
                    ),
                    SizedBox(
                      height: 63,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InsiteButton(
                          bgColor: chipBackgroundOne,
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: MediaQuery.of(context).size.height * 0.06,
                          title: "Cancel",
                          fontSize: 14,
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                        InsiteButton(
                          width: MediaQuery.of(context).size.width * 0.40,
                          height: MediaQuery.of(context).size.height * 0.06,
                          title: "Save",
                          fontSize: 14,
                          onTap: () {
                            if (groups != null) {
                              viewModel.getAddGroupEditData();
                            } else {
                              viewModel.getAddGroupSaveData();
                            }
                          },
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ));
      },
      viewModelBuilder: () => AddGroupViewModel(groups),
    );
  }
}
