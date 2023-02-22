import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartView extends StatefulWidget {
  ChartView({Key? key}) : super(key: key);
  @override
  State<ChartView> createState() => _ChartView2State();
}

class _ChartView2State extends State<ChartView> {
  ChartSeriesController? seriesController1;
  ChartSeriesController? seriesController2;
  ChartSeriesController? seriesController3;
  int a = 10;
  int b = 15;

  @override
  initState() {
    super.initState();
  }

  List<ChartData> chartData = <ChartData>[
    ChartData('D1', 5),
    ChartData('D2', 1),
    ChartData('D3', 2),
    ChartData('D4', 3),
    ChartData('D5', 4),
    ChartData('D6', 10),
    ChartData('D7', 12),
    ChartData('D8', 10),
    ChartData('D9', 19),
    ChartData('D10', 10),
  ];

  List<ChartData> liveData = <ChartData>[
    ChartData('1', 5),
    ChartData('2', 1),
    ChartData('3', 2),
    ChartData('4', 3),
    ChartData('5', 4),
    ChartData('6', 10),
    ChartData('7', 12),
    ChartData('8', 10),
    ChartData('9', 19),
    ChartData('10', 12),
    ChartData('11', 9),
    ChartData('11', 7),
    ChartData('12', 2),
    ChartData('13', 6),
    ChartData('14', 18),
    ChartData('15', 12),
  ];

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
                  title: ChartTitle(text: "Days"),
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
                  primaryYAxis: NumericAxis(),
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
                        name: "Plastic",
                        borderWidth: 2,
                        color: Color.fromARGB(255, 21, 165, 132),
                        //borderRadius: BorderRadius.circular(20),
                        enableTooltip: true,
                        dataSource: chartData,
                        dataLabelMapper: (x, y) => x.x,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                    SplineSeries<ChartData, String>(
                        onRendererCreated: (ChartSeriesController controller) {
                          seriesController2 = controller;
                        },
                        name: "Paper",
                        color: Color.fromARGB(255, 249, 80, 8),
                        //borderRadius: BorderRadius.circular(20),
                        enableTooltip: true,
                        dataSource: chartData,
                        dataLabelMapper: (x, y) => x.x,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y),
                  ],
                ),
                SizedBox(height: 50.h),
                SfCartesianChart(
                  title: ChartTitle(text: "Months"),
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
                        dataSource: liveData,
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
  final double? y;
}
