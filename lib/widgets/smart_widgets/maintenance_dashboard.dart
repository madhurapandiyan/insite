import 'package:flutter/material.dart';
import 'package:insite/core/models/maintenance_dashboard_count.dart';
import 'package:insite/utils/enums.dart';
import 'package:insite/utils/helper_methods.dart';
import 'package:insite/widgets/dumb_widgets/insite_progressbar.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class MaintenanceDashBoard extends StatelessWidget {
  final MaintenanceDashboardCount? countData;
  final bool? isLoading;
  final Function(MAINTENANCETOTAL, String, int count)? onFilterSelected;
  MaintenanceDashBoard({this.countData, this.onFilterSelected, this.isLoading});
  Widget maintenanceDetailCount({DashboardData? data}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InsiteText(
            text: data!.displayName, fontWeight: FontWeight.w700, size: 14.0),
        TextButton.icon(
          onPressed: () {
            onFilterSelected!(
                data.maintenanceTotal!, data.displayName!, data.count!);
          },
          icon: InsiteText(
              text: data.count.toString(),
              fontWeight: FontWeight.w700,
              size: 14.0),
          label: Container(
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Utils.getMaintenanceColor(data.displayName)),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.33,
            margin: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InsiteText(
                    text: "MAINTENANCE",
                    fontWeight: FontWeight.w900,
                    size: 11.0),
                SizedBox(
                  height: 10,
                ),
                Divider(
                  thickness: 2,
                ),
                isLoading!
                    ? Expanded(child: InsiteProgressBar())
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: countData
                              ?.maintenanceDashboard?.dashboardData?.length,
                          itemBuilder: (BuildContext context, int index) {
                            var data = countData
                                ?.maintenanceDashboard?.dashboardData?[index];
                            return Column(
                              children: [
                                maintenanceDetailCount(data: data),
                                data?.subCount != null &&
                                        data!.subCount!.isNotEmpty
                                    ? Container(
                                        height: 100,
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemCount: data.subCount?.length,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return ListTile(
                                              title: InsiteText(
                                                  text: data
                                                      .subCount?[i].displayName,
                                                  fontWeight: FontWeight.w700,
                                                  size: 14.0),
                                              trailing: InsiteText(
                                                  text: data.subCount?[i].count
                                                      .toString(),
                                                  fontWeight: FontWeight.w700,
                                                  size: 14.0),
                                              onTap: () {
                                                onFilterSelected!(
                                                    data.subCount![i]
                                                        .maintenanceTotal!,
                                                    data.displayName!,
                                                    data.subCount![i].count!);
                                              },
                                            );
                                          },
                                        ),
                                      )
                                    : SizedBox()
                              ],
                            );
                          },
                        ),
                      ),
                Divider(
                  thickness: 2,
                ),
                Container(
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InsiteTextAlign(
                          text: "Viewing upcoming data for next 30 days".toUpperCase(),
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w900,
                          size: 10.0)),
                ),
              ],
            )));
  }
}
