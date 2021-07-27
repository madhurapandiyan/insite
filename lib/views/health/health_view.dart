import 'package:flutter/material.dart';
import 'package:insite/views/home/home_view.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'health_view_model.dart';

class HealthView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HealthViewModel>.reactive(
      builder: (BuildContext context, HealthViewModel viewModel, Widget _) {
        return InsiteScaffold(
          viewModel: viewModel,
          onFilterApplied: () {},
          screenType: ScreenType.HEALTH,
          body: Center(
            child: InsiteText(
              text: 'Coming soon !',
              color: Colors.white,
            ),
          ),
        );
      },
      viewModelBuilder: () => HealthViewModel(),
    );
  }
}
