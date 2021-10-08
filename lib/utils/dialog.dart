import 'package:flutter/material.dart';
import 'package:insite/theme/colors.dart';

class ProgressDialog {
  static ProgressDialog _instance = new ProgressDialog.internal();
  static bool _isLoading = false;

  ProgressDialog.internal();

  factory ProgressDialog() => _instance;
  static BuildContext _context;

  static void dismiss() {
    if (_isLoading) {
      Navigator.of(_context).pop();
      _isLoading = false;
    }
  }

  static void show(BuildContext context) async {
    _context = context;
    _isLoading = true;
    await showDialog(
        context: _context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(tuna),
                ),
              )
            ],
          );
        });
  }
}
