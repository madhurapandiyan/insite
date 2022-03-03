import 'package:flutter/material.dart';
import 'package:insite/core/models/search_contact_report_list_response.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class SearchContactReusableWidget extends StatelessWidget {
  final User? user;
  final VoidCallback ? voidCallback;
  const SearchContactReusableWidget({this.user,this.voidCallback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       voidCallback!();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InsiteText(
            text: user!.name,
            fontWeight: FontWeight.w700,
            size: 14,
          ),
          SizedBox(
            height: 10,
          ),
          InsiteText(
            text: user!.email,
            size: 14,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}
