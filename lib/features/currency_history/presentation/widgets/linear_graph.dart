import 'package:dartz/dartz.dart' as z;
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/util/resources/colors_manager.dart';
import '../../../../core/util/resources/extensions_manager.dart';
import '../../../../core/util/resources/font_manager.dart';

class LinearGraph extends StatefulWidget {
  final List<z.Tuple2<DateTime, num>> history;
  const LinearGraph({Key? key, required this.history}) : super(key: key);

  @override
  State<LinearGraph> createState() => _LinearGraphState();
}

class _LinearGraphState extends State<LinearGraph> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 216.rSp,
      width: double.infinity,
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          labelPlacement: LabelPlacement.onTicks,
          edgeLabelPlacement: EdgeLabelPlacement.shift,
          arrangeByIndex: true,
          axisLine: const AxisLine(width: 0),
          isVisible: true,
          isInversed: true,
          labelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 12.rSp,
                color: ColorsManager.darkGrey,
                fontWeight: FontWeightManager.medium,
              ),
          majorTickLines: const MajorTickLines(size: 0),
        ),
        primaryYAxis: NumericAxis(
          //Hide the gridlines of y-axis
          majorGridLines: const MajorGridLines(width: 0),
          //Hide the axis line of y-axis
          axisLine: const AxisLine(width: 0),
          isVisible: false,
        ),
        series: _getDefaultSplineSeries(widget.history),
      ),
    );
  }

  List<SplineSeries<z.Tuple2<DateTime, num>, String>> _getDefaultSplineSeries(
      List<z.Tuple2<DateTime, num>> w) {
    return [
      SplineSeries<z.Tuple2<DateTime, num>, String>(
        dataSource: w,
        xValueMapper: (z.Tuple2<DateTime, num> xValue, _) => xValue.value1.d,
        yValueMapper: (z.Tuple2<DateTime, num> yValue, _) =>
            yValue.value2.toPrecision(4),
        markerSettings: const MarkerSettings(
          isVisible: true,
          color: ColorsManager.lightGrey,
          width: 6,
          height: 6,
        ),
        color: ColorsManager.darkGrey,
        enableTooltip: true,
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          borderColor: ColorsManager.white,
          margin: const EdgeInsets.all(10),
          labelPosition: ChartDataLabelPosition.inside,
          labelIntersectAction: LabelIntersectAction.none,
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontSize: 12.rSp,
                color: ColorsManager.darkGrey.withOpacity(0.5),
                fontWeight: FontWeightManager.medium,
              ),
        ),
        splineType: SplineType.monotonic,
        cardinalSplineTension: 0.9,
      ),
    ];
  }

  @override
  void dispose() {
    // chartData!.clear();
    super.dispose();
  }
}
