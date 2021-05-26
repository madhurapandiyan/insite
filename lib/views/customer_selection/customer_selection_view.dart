import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/dialog.dart';
import 'package:insite/views/appbar/appvar_view.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/widgets/smart_widgets/customer_selection_dropdown.dart';
import 'package:stacked/stacked.dart';
import 'customer_selection_view_model.dart';

class CustomerSelectionView extends StatefulWidget {
  CustomerSelectionView();
  @override
  _CustomerSelectionViewState createState() => _CustomerSelectionViewState();
}

class _CustomerSelectionViewState extends State<CustomerSelectionView> {
  @override
  void initState() {
    super.initState();
    ProgressDialog.show(context);
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerSelectionViewModel>.reactive(
      builder: (BuildContext context, CustomerSelectionViewModel viewModel,
          Widget _) {
        if (viewModel.onAccountSelected) {
          viewModel.onCustomerSelected();
        }
        if (viewModel.youDontHavePermission) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return Container(
                child: Column(
                  children: [
                    Text(
                        "You do not have access to this application, please contact your Administrator to get access"),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(onPressed: () {}, child: Text("CLOSE")),
                      ],
                    )
                  ],
                ),
              );
            },
          );
        }
        return Scaffold(
          backgroundColor: cod_grey,
          appBar: InsiteAppBar(
              screenType: ScreenType.ACCOUNT,
              height: 56,
              isSearchSelected: false,
              onSearchTap: () {},
              shouldShowAccount: false,
              shouldShowFilter: false,
              shouldShowLogout: true,
              shouldShowSearch: false),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "LOGGED IN AS : ",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Expanded(
                          child: Text(
                            viewModel.loggedInUserMail,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 4,
                  color: ship_grey,
                ),
                SizedBox(
                  height: 10,
                ),
                viewModel.youDontHavePermission ? Container() : SizedBox(),
                viewModel.loading
                    ? CircularProgressIndicator()
                    : Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  "CUSTOMER SELECTION :",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                          viewModel.accountSelected != null
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: CustomerSelectionDropDown(
                                    selectionType: SelectionType.ACCOUNT,
                                    onSelected: (SelectedData value) {
                                      ProgressDialog.show(context);
                                      Future.delayed(Duration(seconds: 1), () {
                                        ProgressDialog.dismiss();
                                      });
                                      viewModel.setAccountSelected(value.value);
                                    },
                                    onReset: () {
                                      viewModel.setAccountSelected(null);
                                      viewModel.setSubAccountSelected(null);
                                    },
                                    selected: viewModel.accountSelected != null
                                        ? SelectedData(
                                            selectionType:
                                                SelectionType.ACCOUNT,
                                            value: viewModel.accountSelected)
                                        : null,
                                    list: viewModel.customers,
                                  ))
                              : Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: CustomerSelectionDropDown(
                                    selectionType: SelectionType.ACCOUNT,
                                    onSelected: (SelectedData value) {
                                      ProgressDialog.show(context);
                                      Future.delayed(Duration(seconds: 1), () {
                                        ProgressDialog.dismiss();
                                      });
                                      viewModel.setAccountSelected(value.value);
                                    },
                                    onReset: () {
                                      viewModel.setAccountSelected(null);
                                      viewModel.setSubAccountSelected(null);
                                    },
                                    selected: viewModel.accountSelected != null
                                        ? SelectedData(
                                            selectionType:
                                                SelectionType.ACCOUNT,
                                            value: viewModel.accountSelected)
                                        : null,
                                    list: viewModel.customers,
                                  )),
                          viewModel.accountSelected != null &&
                                  viewModel.subAccountSelected == null &&
                                  viewModel.subCustomers.isNotEmpty
                              ? SizedBox(
                                  height: 10,
                                )
                              : SizedBox(),
                          viewModel.accountSelected != null &&
                                      viewModel.subAccountSelected == null &&
                                      viewModel.subCustomers.isNotEmpty ||
                                  viewModel.accountSelected != null &&
                                      viewModel.subAccountSelected != null &&
                                      viewModel.subCustomers.isNotEmpty
                              ? Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: CustomerSelectionDropDown(
                                    selectionType: SelectionType.CUSTOMER,
                                    onSelected: (value) {
                                      ProgressDialog.show(context);
                                      viewModel
                                          .setSubAccountSelected(value.value);
                                      Future.delayed(Duration(seconds: 1), () {
                                        ProgressDialog.dismiss();
                                        viewModel.onCustomerSelected();
                                      });
                                    },
                                    onReset: () {
                                      viewModel.setAccountSelected(null);
                                      viewModel.setSubAccountSelected(null);
                                    },
                                    selected: viewModel.subAccountSelected !=
                                            null
                                        ? SelectedData(
                                            selectionType:
                                                SelectionType.CUSTOMER,
                                            value: viewModel.subAccountSelected)
                                        : null,
                                    list: viewModel.subCustomers,
                                  ),
                                )
                              : SizedBox(),
                        ],
                      ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => CustomerSelectionViewModel(),
    );
  }
}
