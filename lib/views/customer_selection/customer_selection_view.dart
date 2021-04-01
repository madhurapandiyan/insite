import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
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
  String accountSelected = "";
  String customerSelected = "";
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerSelectionViewModel>.reactive(
      builder: (BuildContext context, CustomerSelectionViewModel viewModel,
          Widget _) {
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
                  child: Row(
                    children: [
                      Text(
                        "LOGGED IN AS : ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      Text(
                        "johndoe@gmail.com",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      )
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
                        accountSelected = value.value;
                        viewModel.setAccountSelected(true);
                      },
                      onReset: () {
                        viewModel.setAccountSelected(false);
                        viewModel.setCustomerSelected(false);
                      },
                      selected: "(1050) TATA HITACHI CORPORATE",
                      showList: false,
                    )),
                viewModel.isAccountSelected && !viewModel.isCustomerSelected
                    ? SizedBox(
                        height: 10,
                      )
                    : SizedBox(),
                viewModel.isAccountSelected && !viewModel.isCustomerSelected
                    ? Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: CustomerSelectionDropDown(
                          selectionType: SelectionType.CUSTOMER,
                          onSelected: (value) {
                            customerSelected = value.value;
                            viewModel.setAccountSelected(true);
                            widget.onCustomerSelected();
                          },
                          onReset: () {
                            viewModel.setAccountSelected(false);
                            viewModel.setCustomerSelected(false);
                          },
                          selected: "CUSTOMERS",
                          showList: false,
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
