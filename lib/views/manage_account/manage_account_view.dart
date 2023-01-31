import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'manage_account_view_model.dart';

class ManageAccountView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageAccountViewModel>.reactive(
      builder:
          (BuildContext context, ManageAccountViewModel viewModel, Widget? _) {
        return WillPopScope(
          onWillPop: () {
            viewModel.onWillPop(context);

            throw false;
          },
          child: Scaffold(
              backgroundColor: Theme.of(context).backgroundColor,
              body: SafeArea(
                child: Stack(
                  children: [
                    WebviewScaffold(
                      clearCache: true,
                      clearCookies: true,
                      url: "https://myprofile.trimble.com/home",
                    ),
                  ],
                ),
              )),
        );
      },
      viewModelBuilder: () => ManageAccountViewModel(),
    );
  }
}
