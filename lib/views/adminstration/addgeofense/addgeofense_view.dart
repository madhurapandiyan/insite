import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:insite/views/adminstration/addgeofense/formfield.dart/formfieldwidget.dart';
import 'package:insite/views/adminstration/reusable_widget/dropdown.dart';

import 'package:insite/widgets/dumb_widgets/insite_button.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:insite/widgets/smart_widgets/insite_scaffold.dart';
import 'package:stacked/stacked.dart';
import 'addgeofense_view_model.dart';

class AddgeofenseView extends StatefulWidget {
  @override
  State<AddgeofenseView> createState() => _AddgeofenseViewState();
}

class _AddgeofenseViewState extends State<AddgeofenseView> {
  Widget tapbutton(IconData icons, double height, double width, Color color,
      double imgheight, double imgwidth) {
    return Container(
      alignment: Alignment.center,
      width: width,
      height: height,
      margin: EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: color,
      ),
      child: Center(
          child: Icon(
        icons,
        color: icons == Icons.fiber_manual_record_rounded ? Colors.red : null,
      )),
    );
  }

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
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InsiteText(
                        text: "Add Geofence",
                        fontWeight: FontWeight.w700,
                        size: 20,
                      ),
                      InsiteButton(
                        title: "MANAGE GEOFENCE",
                        height: mediaquerry.size.height * 0.05,
                        width: mediaquerry.size.width * 0.4,
                      )
                    ],
                  ),
                ),
                Container(
                  height: mediaquerry.size.height * 0.55,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: theme.cardColor,
                  ),
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                        height: mediaquerry.size.height * 0.55,
                        margin:
                            EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: theme.backgroundColor,
                        ),
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                tapbutton(
                                  Icons.add,
                                  mediaquerry.size.height * 0.05,
                                  mediaquerry.size.width * 0.10,
                                  theme.cardColor,
                                  mediaquerry.size.height * 0.02,
                                  mediaquerry.size.width * 0.05,
                                ),
                                Dropdown(),
                                tapbutton(
                                  Icons.search,
                                  mediaquerry.size.height * 0.05,
                                  mediaquerry.size.width * 0.10,
                                  theme.cardColor,
                                  mediaquerry.size.height * 0.02,
                                  mediaquerry.size.width * 0.05,
                                ),
                                tapbutton(
                                  Icons.mode_edit_outlined,
                                  mediaquerry.size.height * 0.05,
                                  mediaquerry.size.width * 0.10,
                                  theme.cardColor,
                                  mediaquerry.size.height * 0.02,
                                  mediaquerry.size.width * 0.05,
                                ),
                              ],
                            ),
                            Container(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  tapbutton(
                                    Icons.minimize_outlined,
                                    mediaquerry.size.height * 0.05,
                                    mediaquerry.size.width * 0.10,
                                    theme.cardColor,
                                    mediaquerry.size.height * 0.02,
                                    mediaquerry.size.width * 0.05,
                                  ),
                                  Column(
                                    children: [
                                      tapbutton(
                                        Icons.delete,
                                        mediaquerry.size.height * 0.05,
                                        mediaquerry.size.width * 0.10,
                                        theme.cardColor,
                                        mediaquerry.size.height * 0.02,
                                        mediaquerry.size.width * 0.05,
                                      ),
                                      tapbutton(
                                        Icons.fiber_manual_record_rounded,
                                        mediaquerry.size.height * 0.05,
                                        mediaquerry.size.width * 0.10,
                                        theme.cardColor,
                                        mediaquerry.size.height * 0.02,
                                        mediaquerry.size.width * 0.05,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Formfieldwidget(
                      viewModel.dropDownlist,
                      viewModel.value,
                      viewModel.setDefaultPreferenceToUser,
                      viewModel.allowAccessToSecurity,
                      viewModel.change_checkboxstate),
                )
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => AddgeofenseViewModel(),
    );
  }
}
