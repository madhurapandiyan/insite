import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';

class IncrementDecrementwidget extends StatefulWidget {
  final Function(String) onValueChange;
  final String countValue;
  final TextEditingController textEditingController;

  const IncrementDecrementwidget(
      {this.onValueChange, this.countValue, this.textEditingController});

  @override
  _IncrementDecrementwidgetState createState() =>
      _IncrementDecrementwidgetState();
}

class _IncrementDecrementwidgetState extends State<IncrementDecrementwidget> {
  TextEditingController fullWeekValue = new TextEditingController(text: "0");

  @override
  void initState() {
    fullWeekValue.text = widget.countValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant IncrementDecrementwidget oldWidget) {
    fullWeekValue.text = widget.countValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    fullWeekValue.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              contentPadding: EdgeInsets.only(left: 33.0),
            ),
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.bodyText1.color),
            controller: fullWeekValue,
            keyboardType: TextInputType.numberWithOptions(
              decimal: false,
              signed: true,
            ),
            inputFormatters: <TextInputFormatter>[
              WhitelistingTextInputFormatter.digitsOnly
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  child: Icon(
                    Icons.arrow_drop_up,
                    size: 18.0,
                  ),
                  onTap: () {
                    getIncrementValue();
                  }),
              InkWell(
                  child: Icon(
                    Icons.arrow_drop_down,
                    size: 18.0,
                  ),
                  onTap: () {
                    getDecrementValue();
                  }),
            ],
          ),
        )
      ],
    );
  }

  void getIncrementValue() {
    Logger().i(fullWeekValue.text);
    try {
      int currentValue = 0;
      if (fullWeekValue.text.isNotEmpty) {
        currentValue = int.parse(fullWeekValue.text);
      }
      currentValue++;
      fullWeekValue.text = (currentValue).toString();
      widget.onValueChange(fullWeekValue.text);
      setState(() {});
    } catch (e) {
      Logger().e(e.toString());
    }
  }

  void getDecrementValue() {
    Logger().i(fullWeekValue.text);
    try {
      int currentValue = 0;
      if (fullWeekValue.text.isNotEmpty) {
        currentValue = int.parse(fullWeekValue.text);
      }
      currentValue--;
      fullWeekValue.text = (currentValue > 0 ? currentValue : 0).toString();
      widget.onValueChange(fullWeekValue.text);
      setState(() {});
    } catch (e) {
      Logger().e(e.toString());
    }
  }
}
