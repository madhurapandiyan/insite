import 'package:flutter/material.dart';
import 'package:insite/core/models/account.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/appbar/appbar_view.dart';
import 'package:insite/widgets/dumb_widgets/empty_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/customer_selection_dropdown.dart';
import 'package:stacked/stacked.dart';
import 'account_search_view.dart';
import 'account_selection_view_model.dart';

class AccountSelectionView extends StatefulWidget {
  AccountSelectionView();
  @override
  _AccountSelectionViewState createState() => _AccountSelectionViewState();
}

class _AccountSelectionViewState extends State<AccountSelectionView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountSelectionViewModel>.reactive(
      builder: (BuildContext context, AccountSelectionViewModel viewModel,
          Widget? _) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
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
                        child: InsiteText(
                            text: "LOGGED IN AS : ",
                            fontWeight: FontWeight.bold,
                            size: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          viewModel.loggedInUserMail!,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
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
                viewModel.loading
                    ? InsiteProgressBar()
                    : Stack(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: InsiteText(
                                        text: "ACCOUNT SELECTION :",
                                        fontWeight: FontWeight.bold,
                                        size: 18),
                                  ),
                                ],
                              ),
                              viewModel.accountSelected != null
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: AccountSelectionDropDownWidget(
                                        selectionType: AccountType.ACCOUNT,
                                        onSelected: (AccountData? value) {
                                          viewModel
                                              .setAccountSelected(value!.value);
                                        },
                                        onReset: () {
                                          viewModel.resetSelection();
                                        },
                                        selected: viewModel.accountSelected !=
                                                null
                                            ? AccountData(
                                                selectionType:
                                                    AccountType.ACCOUNT,
                                                value:
                                                    viewModel.accountSelected)
                                            : null,
                                        list: viewModel.customers,
                                      ))
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: AccountSearchView(
                                        selectionType: AccountType.ACCOUNT,
                                        onSelected: (AccountData? value) {
                                          viewModel
                                              .setAccountSelected(value!.value);
                                        },
                                        onReset: () {
                                          viewModel.resetSelection();
                                        },
                                        selected: null,
                                        list: viewModel.customers,
                                      )),
                              viewModel.accountSelected != null &&
                                          viewModel.subAccountSelected ==
                                              null &&
                                          viewModel.subCustomers.isNotEmpty ||
                                      viewModel.accountSelected != null &&
                                          viewModel.subAccountSelected !=
                                              null &&
                                          viewModel.subCustomers.isNotEmpty
                                  ? 
                                  Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 8),
                                      child: AccountSearchView(
                                        selectionType: AccountType.CUSTOMER,
                                        onSelected: (value) {
                                          viewModel.setSubAccountSelected(
                                              value!.value!);
                                          viewModel.onCustomerSelected();
                                        },
                                        onReset: () {
                                          viewModel.resetSelection();
                                        },
                                        selected:
                                            viewModel.subAccountSelected != null
                                                ? AccountData(
                                                    selectionType:
                                                        AccountType.CUSTOMER,
                                                    value: viewModel
                                                        .subAccountSelected)
                                                : null,
                                        list: viewModel.subCustomers,
                                      ),
                                    )
                                  : SizedBox(),
                            ],
                          ),
                          viewModel.secondaryLoading
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: InsiteProgressBar(),
                                )
                              : SizedBox(),
                          viewModel.youDontHavePermission
                              ? Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.5,
                                  child: EmptyView(
                                    title:
                                        "You do not have access to this application, please contact your Administrator to get access",
                                  ))
                              : SizedBox()
                        ],
                      ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => AccountSelectionViewModel(),
    );
  }
}
