import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';
import 'package:insite/widgets/dumb_widgets/insite_button.dart';

class NewReportTemplateWidget extends StatelessWidget {
  // const NewReportTemplateWidget({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.288,
      decoration: BoxDecoration(
        boxShadow: [new BoxShadow(blurRadius: 1.0, color: tuna)],
        border: Border.all(width: 2.5, color: tuna),
        borderRadius: BorderRadius.circular(10),
        shape: BoxShape.rectangle,
      ),
      child: Column(
        
        children: [
          Container(
            margin: EdgeInsets.all(8),
            width: MediaQuery.of(context).size.width * 0.86,
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: BoxDecoration(
              boxShadow: [new BoxShadow(blurRadius: 1.0, color: bgcolor)],
              border: Border.all(width: 2.5, color: bgcolor),
              borderRadius: BorderRadius.circular(10),
              shape: BoxShape.rectangle,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Text(
                    "Asset Event Count",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: textcolor,
                        fontSize: 18,
                        fontFamily: 'Roboto',
                        fontStyle: FontStyle.normal),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    "The Asset event count report provides a " +
                        "\n" +
                        "summary of all the events over a 31 day" +
                        "\n" +
                        "period for a single asset .",
                    style: TextStyle(
                        fontSize: 14,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400,
                        color: textcolor),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
               InsiteButton(
            width: MediaQuery.of(context).size.width * 0.40,
            height: MediaQuery.of(context).size.height * 0.05,
            title: "View Sample",
            fontSize: 14,
            textColor: appbarcolor,
            bgColor: ship_grey,
            onTap: (){},
          ),
           InsiteButton(
            width: MediaQuery.of(context).size.width * 0.40,
            height: MediaQuery.of(context).size.height * 0.05,
            title: "Email Report",
            fontSize: 14,
            textColor: appbarcolor,
            bgColor: tango,
            onTap: (){},
          )

            ],
          )
         
        ],
      ),
    );
  }
}
