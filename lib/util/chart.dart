// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartView extends StatefulWidget {
  List<int> organics;
  List<int> inorganics;
  List<int> recyclables;
  List<int> total;
  ChartView({
    Key? key,
    required this.organics,
    required this.inorganics,
    required this.recyclables,
    required this.total,
  }) : super(key: key);
  @override
  State<ChartView> createState() => _ChartView2State();
}

class _ChartView2State extends State<ChartView> {
  ChartSeriesController? seriesController1;
  ChartSeriesController? seriesController2;
  ChartSeriesController? seriesController3;
  List<ChartData> chartOrganics = <ChartData>[];
  List<ChartData> chartInorganics = <ChartData>[];
  List<ChartData> chartRecyclables = <ChartData>[];
  List<ChartData> chartTotal = <ChartData>[];

  @override
  initState() {
    setDataForChart();
    super.initState();
  }

  @override
  void dispose() {
    chartInorganics.clear();
    chartOrganics.clear();
    chartTotal.clear();
    chartRecyclables.clear();
    super.dispose();
  }

  void setDataForChart() {
    for (int i = 0; i < widget.organics.length; i++) {
      if (i == 0) {
        chartOrganics.add(ChartData("Today", widget.organics[i]));
      } else {
        chartOrganics.add(ChartData(convertTime(i), widget.organics[i]));
      }
    }
    chartOrganics = List.from(chartOrganics.reversed);
    for (int i = 0; i < widget.organics.length; i++) {
      if (i == 0) {
        chartInorganics.add(ChartData("Today", widget.inorganics[i]));
      } else {
        chartInorganics.add(ChartData(convertTime(i), widget.inorganics[i]));
      }
    }
    chartInorganics = List.from(chartInorganics.reversed);
    for (int i = 0; i < widget.organics.length; i++) {
      if (i == 0) {
        chartRecyclables.add(ChartData("Today", widget.recyclables[i]));
      } else {
        chartRecyclables.add(ChartData(convertTime(i), widget.recyclables[i]));
      }
    }
    chartRecyclables = List.from(chartRecyclables.reversed);
    for (int i = 0; i < widget.organics.length; i++) {
      if (i == 0) {
        chartTotal.add(ChartData("Today", widget.total[i]));
      } else {
        chartTotal.add(ChartData(convertTime(i), widget.total[i]));
      }
    }
    chartTotal = List.from(chartTotal.reversed);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SfCartesianChart(
                  title: ChartTitle(text: "Garbage sorting"),
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    title: LegendTitle(
                        textStyle: const TextStyle(
                            color: Colors.red, fontSize: 15, fontStyle: FontStyle.italic, fontWeight: FontWeight.w900)),
                  ),
                  enableMultiSelection: true,
                  enableAxisAnimation: true,
                  zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true, enablePinching: true, maximumZoomLevel: 0.5, zoomMode: ZoomMode.x),
                  primaryXAxis: CategoryAxis(
                      maximumLabels: 15,
                      labelPosition: ChartDataLabelPosition.outside,
                      interactiveTooltip: const InteractiveTooltip(enable: true, color: Colors.blue)),
                  primaryYAxis: NumericAxis(),
                  // loadMoreIndicatorBuilder: (BuildContext context, ChartSwipeDirection direction) =>
                  //     getLoadMoreViewBuilder(context, direction),
                  trackballBehavior: TrackballBehavior(enable: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    // Render column series
                    LineSeries<ChartData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          seriesController1 = controller;
                        },
                        name: "Organics",
                        // borderWidth: 2,
                        color: Color.fromARGB(255, 21, 165, 132),
                        //borderRadius: BorderRadius.circular(20),
                        enableTooltip: true,
                        dataSource: chartOrganics,
                        dataLabelMapper: (x, y) => x.x,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                    LineSeries<ChartData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          seriesController2 = controller;
                        },
                        name: "Inorganics",
                        color: Colors.red,
                        //borderRadius: BorderRadius.circular(20),
                        enableTooltip: true,
                        dataSource: chartInorganics,
                        dataLabelMapper: (x, y) => x.x,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                    LineSeries<ChartData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          seriesController2 = controller;
                        },
                        name: "Recyclables",
                        color: Colors.lightGreen,
                        //borderRadius: BorderRadius.circular(20),
                        enableTooltip: true,
                        dataSource: chartRecyclables,
                        dataLabelMapper: (x, y) => x.x,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                  ],
                ),
                SizedBox(height: 50.h),
                SfCartesianChart(
                  title: ChartTitle(text: "Total %"),
                  legend: Legend(
                    isVisible: true,
                    position: LegendPosition.bottom,
                    title: LegendTitle(
                        textStyle: const TextStyle(
                      color: Colors.red,
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                    )),
                  ),
                  enableMultiSelection: true,
                  enableAxisAnimation: true,
                  zoomPanBehavior: ZoomPanBehavior(
                      enablePanning: true, enablePinching: true, maximumZoomLevel: 0.5, zoomMode: ZoomMode.x),
                  primaryXAxis: CategoryAxis(),
                  primaryYAxis: NumericAxis(title: AxisTitle(text: "%", alignment: ChartAlignment.center)),
                  // loadMoreIndicatorBuilder: (BuildContext context, ChartSwipeDirection direction) =>
                  //     getLoadMoreViewBuilder(context, direction),
                  trackballBehavior: TrackballBehavior(enable: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    ColumnSeries<ChartData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          seriesController3 = controller;
                        },
                        name: "Total rubbish",
                        color: Colors.blue,
                        borderColor: Colors.lightBlue,
                        //borderRadius: BorderRadius.circular(20),
                        enableTooltip: true,
                        dataSource: chartTotal,
                        dataLabelMapper: (x, y) => x.x,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);
  final String x;
  final int? y;
}

String convertTime(int i) {
  DateTime now = DateTime.now();
  var a = [1, 3, 5, 7, 8, 10, 12];
  var b = [4, 6, 9, 11];
  int day;
  int month;
  if (a.contains(now.month) && now.day - i <= 0) {
    day = now.day - i + (now.month != 3 ? 30 : 28);
    if (now.month == 1) {
      month = 12;
    } else {
      month = now.month - 1;
    }
  } else if (now.day - i <= 0) {
    day = now.day - i + 31;
    month = now.month - 1;
  } else {
    day = now.day - i;
    month = now.month;
  }
  return "$day/$month";
}
