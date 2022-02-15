import 'package:flutter/widgets.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/views/adminstration/manage_report/manage_report_view_model.dart';
import 'package:insite/views/adminstration/reusable_widget/new_report_template_widget.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';

class TemplateView extends StatefulWidget {
  //const TemplateView({ Key? key }) : super(key: key);

  @override
  _TemplateViewState createState() => _TemplateViewState();
}

class _TemplateViewState extends State<TemplateView> {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ManageReportViewModel>.reactive(
      builder:
          (BuildContext context, ManageReportViewModel viewModel, Widget? _) {
        return InsiteScaffold(
          viewModel: viewModel,
          screenType: ScreenType.ADMINISTRATION,
          body: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              viewModel.loading
                  ? InsiteProgressBar()
                  : Expanded(
                      child: ListView.builder(
                          itemCount: viewModel.templateAssets.length,
                          itemBuilder: (context, index) {
                            var templateAssets =
                                viewModel.templateAssets[index];
                            Logger().i(templateAssets);
                            return NewReportTemplateWidget(
                              voidCallback: (){
                                viewModel.onClickAddReportSelected();
                              },
                              reportTypeName: templateAssets,
                            );
                          }),
                    )
            ],
          ),
        );
      },
      viewModelBuilder: () => ManageReportViewModel(true),
    );
  }
}
