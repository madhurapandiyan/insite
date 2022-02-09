import 'package:flutter/material.dart';
import 'package:insite/views/add_new_user/reusable_widget/custom_dropdown_widget.dart';

class TimeSlots extends StatelessWidget {
  List<String>? type;
  List<String>? startTime;
  List<String>? endTime;

  TimeSlots({this.type, this.endTime, this.startTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: 150,
        width: double.infinity,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).textTheme.bodyText1!.color!,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: CustomDropDownWidget(
                value: "select",
                items: type,
                enableHint: true,
                onChanged: (String? value) {
                  // viewModel.updateModelValue(value!);
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).textTheme.bodyText1!.color!,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomDropDownWidget(
                    value: "select",
                    items: startTime,
                    enableHint: true,
                    onChanged: (String? value) {
                      // viewModel.updateModelValue(value!);
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 50,
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).textTheme.bodyText1!.color!,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomDropDownWidget(
                    value: "select",
                    items: endTime,
                    enableHint: true,
                    onChanged: (String? value) {
                      // viewModel.updateModelValue(value!);
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
