import 'package:flutter/material.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';

class InsiteDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onPositiveActionClicked;
  final VoidCallback? onNegativeActionClicked;
  const InsiteDialog(
      {Key? key,
      this.message,
      this.title,
      this.onPositiveActionClicked,
      this.onNegativeActionClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InsiteText(text: title, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: InsiteText(
              text: message,
            ),
          ),
          ButtonBar(children: [
            TextButton(
              child: InsiteText(
                text: "NO",
              ),
              onPressed: () async {
                onNegativeActionClicked!();
              },
            ),
            SizedBox(
              width: 5,
            ),
            TextButton(
              child: InsiteText(
                text: 'YES',
              ),
              onPressed: () async {
                onPositiveActionClicked!();
              },
            ),
          ]),
        ],
      ),
    );
  }
}

class InsiteInfoDialog extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onOkClicked;
  const InsiteInfoDialog({Key? key, this.message, this.title, this.onOkClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: InsiteText(text: title, fontWeight: FontWeight.bold)),
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: InsiteText(
              text: message,
            ),
          ),
          ButtonBar(children: [
            SizedBox(
              width: 5,
            ),
            TextButton(
              child: InsiteText(
                text: 'OK',
              ),
              onPressed: () async {
                onOkClicked!();
              },
            ),
          ]),
        ],
      ),
    );
  }
}
