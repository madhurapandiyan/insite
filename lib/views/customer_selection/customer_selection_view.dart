import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/dialog.dart';
import 'package:insite/widgets/smart_widgets/customer_selection_dropdown.dart';
import 'package:stacked/stacked.dart';
import 'customer_selection_view_model.dart';

class CustomerSelectionView extends StatefulWidget {
  final VoidCallback onCustomerSelected;
  CustomerSelectionView({this.onCustomerSelected});
  @override
  _CustomerSelectionViewState createState() => _CustomerSelectionViewState();
}

class _CustomerSelectionViewState extends State<CustomerSelectionView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerSelectionViewModel>.reactive(
      builder: (BuildContext context, CustomerSelectionViewModel viewModel,
          Widget _) {
        if (viewModel.onAccountSelected) {
          widget.onCustomerSelected();
        }
        return Scaffold(
          backgroundColor: cod_grey,
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
                Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: CustomerSelectionDropDown(
                      selectionType: SelectionType.ACCOUNT,
                      onSelected: (SelectedData value) {
                        ProgressDialog.show(context);
                        viewModel.setAccountSelected(value.value);
                        Future.delayed(Duration(seconds: 1), () {
                          ProgressDialog.dismiss();
                        });
                      },
                      onReset: () {
                        viewModel.setAccountSelected(null);
                        viewModel.setSubAccountSelected(null);
                      },
                      selected: viewModel.accountSelected != null
                          ? SelectedData(
                              selectionType: SelectionType.ACCOUNT,
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
                            viewModel.setSubAccountSelected(value.value);
                            Future.delayed(Duration(seconds: 1), () {
                              ProgressDialog.dismiss();
                              widget.onCustomerSelected();
                            });
                          },
                          onReset: () {
                            viewModel.setAccountSelected(null);
                            viewModel.setSubAccountSelected(null);
                          },
                          selected: viewModel.subAccountSelected != null
                              ? SelectedData(
                                  selectionType: SelectionType.CUSTOMER,
                                  value: viewModel.subAccountSelected)
                              : null,
                          list: viewModel.subCustomers,
                        ),
                      )
                    : SizedBox(),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => CustomerSelectionViewModel(),
    );
  }
}
