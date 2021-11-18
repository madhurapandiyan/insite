import 'package:flutter/material.dart';
import 'package:insite/views/adminstration/asset_settings_configure/model/configure_grid_view_model.dart';
import 'package:insite/widgets/dumb_widgets/insite_text.dart';
import 'package:logger/logger.dart';

class TransportGridViewWidget extends StatelessWidget {
  final VoidCallback voidCallback;
  final int selectedIndex;
  final int index;
  final ConfigureGridViewModel items;
  const TransportGridViewWidget({ this.voidCallback,this.selectedIndex,this.index ,this.items}); 

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       voidCallback();
      },
      child: Card(
        semanticContainer: true,
        color:
            selectedIndex != null && selectedIndex == index
                ? Theme.of(context).buttonColor
                : Theme.of(context).cardColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                items.image,
                color: selectedIndex != null &&
                        selectedIndex == index
                    ? Colors.white
                    : Theme.of(context).iconTheme.color,
              ),
              SizedBox(height: 8.0),
              InsiteTextAlign(
                  textAlign: TextAlign.center,
                  color: selectedIndex != null &&
                         selectedIndex == index
                      ? Colors.white
                      : Theme.of(context).iconTheme.color,
                  fontWeight: FontWeight.bold,
                  size: 12,
                  text: items.modelName),
            ],
          ),
        ),
      ),
    );
  }
}