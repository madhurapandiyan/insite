import 'package:flutter/material.dart';

class SingleAssetOperationChartData {
  @required
  final double startTime;
  @required
  final double endTime;
  @required
  final String localDate;

  SingleAssetOperationChartData(this.startTime, this.endTime, this.localDate);
}
