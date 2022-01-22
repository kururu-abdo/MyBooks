import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class PopulationData {
  int? month;
  int? population;
  charts.Color? barColor;
  PopulationData({
     this.month, 
     this.population,
     this.barColor
  });
}