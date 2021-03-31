import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/smart_widgets/customer_selection_dropdown.dart';
import 'package:stacked/stacked.dart';
import 'customer_selection_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class CustomerSelectionView extends StatefulWidget {
  @override
  _CustomerSelectionViewState createState() => _CustomerSelectionViewState();
}

class _CustomerSelectionViewState extends State<CustomerSelectionView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CustomerSelectionViewModel>.reactive(
      builder: (BuildContext context, CustomerSelectionViewModel viewModel,
          Widget _) {
        return Material(
          color: cod_grey,
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
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: CustomerSelectionDropDown(
                  selectionType: SelectionType.ACCOUNT,
                  onSelected: (value) {},
                  selected: "(1050) TATA HITACHI CORPORATE",
                ),
              ),
              SizedBox(),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              //   child: CustomerSelectionDropDown(
              //     selectionType: SelectionType.CUSTOMER,
              //     onSelected: (value) {},
              //     selected: "CUSTOMERS",
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    InsiteButton(
                      bgColor: Colors.white,
                      textColor: ship_grey,
                      onTap: () {},
                      width: 100,
                      height: 48,
                      title: "RESET",
                    ),
                    SizedBox(
                      height: 20,
                      width: 40,
                    ),
                    InsiteButton(
                      bgColor: tango,
                      height: 48,
                      width: 100,
                      textColor: Colors.white,
                      onTap: () {},
                      title: "SELECT",
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.end,
                ),
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => CustomerSelectionViewModel(),
    );
  }
}
