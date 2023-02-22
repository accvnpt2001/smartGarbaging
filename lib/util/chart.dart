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
    int today = DateTime.now().day;
    int month = DateTime.now().month;
    for (var e in widget.organics) {
      if (widget.organics.indexOf(e) == 0) {
        chartOrganics.add(ChartData("Today", e));
      } else {
        chartOrganics.add(ChartData("${today - widget.organics.indexOf(e)}/$month", e));
      }
    }
    chartOrganics = List.from(chartOrganics.reversed);

    for (var e in widget.inorganics) {
      if (widget.inorganics.indexOf(e) == 0) {
        chartInorganics.add(ChartData("Today", e));
      } else {
        chartInorganics.add(ChartData("${today - widget.inorganics.indexOf(e)}/$month", e));
      }
    }
    chartInorganics = List.from(chartInorganics.reversed);

    for (var e in widget.recyclables) {
      if (widget.recyclables.indexOf(e) == 0) {
        chartRecyclables.add(ChartData("Today", e));
      } else {
        chartRecyclables.add(ChartData("${today - widget.recyclables.indexOf(e)}/$month", e));
      }
    }
    chartRecyclables = List.from(chartRecyclables.reversed);

    for (var e in widget.total) {
      if (widget.total.indexOf(e) == 0) {
        chartTotal.add(ChartData("Today", e));
      } else {
        chartTotal.add(ChartData("${today - widget.total.indexOf(e)}/$month", e));
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
                        text: 'Note',
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
                      interactiveTooltip: InteractiveTooltip(enable: true, color: Colors.blue)),
                  primaryYAxis: NumericAxis(maximum: 100, interval: 20),
                  // loadMoreIndicatorBuilder: (BuildContext context, ChartSwipeDirection direction) =>
                  //     getLoadMoreViewBuilder(context, direction),
                  trackballBehavior: TrackballBehavior(enable: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    // Render column series
                    ColumnSeries<ChartData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          seriesController1 = controller;
                        },
                        name: "Organics",
                        borderWidth: 2,
                        color: Color.fromARGB(255, 21, 165, 132),
                        //borderRadius: BorderRadius.circular(20),
                        enableTooltip: true,
                        dataSource: chartOrganics,
                        dataLabelMapper: (x, y) => x.x,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                    SplineSeries<ChartData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          seriesController2 = controller;
                        },
                        name: "Inorganics",
                        color: Color.fromARGB(255, 249, 80, 8),
                        //borderRadius: BorderRadius.circular(20),
                        enableTooltip: true,
                        dataSource: chartInorganics,
                        dataLabelMapper: (x, y) => x.x,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                  ],
                ),
                SizedBox(height: 50.h),
                SfCartesianChart(
                  title: ChartTitle(text: "Total"),
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
                  primaryYAxis: NumericAxis(),
                  // loadMoreIndicatorBuilder: (BuildContext context, ChartSwipeDirection direction) =>
                  //     getLoadMoreViewBuilder(context, direction),
                  trackballBehavior: TrackballBehavior(enable: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                  series: <CartesianSeries>[
                    AreaSeries<ChartData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          seriesController3 = controller;
                        },
                        name: "Time",
                        color: Color.fromARGB(112, 8, 157, 249),
                        borderColor: Color.fromARGB(255, 8, 157, 249),
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
