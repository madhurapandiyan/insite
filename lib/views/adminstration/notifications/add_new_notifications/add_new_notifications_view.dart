import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'add_new_notifications_view_model.dart';

class AddNewNotificationsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AddNewNotificationsViewModel>.reactive(
      builder: (BuildContext context, AddNewNotificationsViewModel viewModel,
          Widget? _) {
        return Scaffold(
          appBar: AppBar(),
          body: Center(
            child: Text('AddNewNotifications View'),
          ),
        );
      },
      viewModelBuilder: () => AddNewNotificationsViewModel(),
    );
  }
}
