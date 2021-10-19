import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'addgeofense_view_model.dart';

class AddgeofenseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaquerry = MediaQuery.of(context);
    var theme = Theme.of(context);
    return ViewModelBuilder<AddgeofenseViewModel>.reactive(
      builder:
          (BuildContext context, AddgeofenseViewModel viewModel, Widget _) {
        return InsiteScaffold(
          onFilterApplied: () {},
          viewModel: viewModel,
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InsiteText(
                      text: "Manage Geofence",
                      fontWeight: FontWeight.w700,
                      size: 20,
                    ),
                    InsiteButton(
                      title: "ADD GEOFENCE",
                      height: mediaquerry.size.height * 0.05,
                      width: mediaquerry.size.width * 0.4,
                    )
                  ],
                ),
              ),
              Container(
                height: mediaquerry.size.height * 0.40,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                padding: EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.cardColor,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          height: mediaquerry.size.height * 0.25,
                          margin:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme.backgroundColor,
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          width: mediaquerry.size.width * 0.15,
                          height: mediaquerry.size.height * 0.07,
                          margin: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: theme.cardColor,
                          ),
                          child: SvgPicture.asset(
                            "assets/images/delete.svg",
                            height: mediaquerry.size.height * 0.03,
                            width: mediaquerry.size.width * 0.1,
                            //fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FittedBox(
                            child: InsiteText(
                              text: "Geofence 123",
                              fontWeight: FontWeight.w700,
                              size: 17,
                            ),
                          ),
                          InsiteText(
                            text: "End Date : No End Date",
                            fontWeight: FontWeight.w700,
                            size: 17,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        );
      },
      viewModelBuilder: () => AddgeofenseViewModel(),
    );
  }
}
