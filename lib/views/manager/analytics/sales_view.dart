

import 'package:push_price_manager/utils/extension.dart';
import 'package:push_price_manager/views/manager/analytics/chart_view.dart';

import '../../../export_all.dart';

class SalesView extends StatefulWidget {
  const SalesView({super.key});

  @override
  State<SalesView> createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  TimeFrame _selectedTimeFrame = TimeFrame.weekly;

  final List<FlSpot> weeklyData = const [
    FlSpot(0, 500),
    FlSpot(1, 400),
    FlSpot(2, 300),
    FlSpot(3, 200),
  ];

  final List<FlSpot> monthlyData = const [
    FlSpot(0, 1200),
    FlSpot(1, 1800),
    FlSpot(2, 900),
    FlSpot(3, 1500),
    FlSpot(4, 2100),
    FlSpot(5, 1700),
  ];

  final List<FlSpot> yearlyData = const [
    FlSpot(0, 8000),
    FlSpot(1, 12000),
    FlSpot(2, 15000),
    FlSpot(3, 18000),
    FlSpot(4, 21000),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(AppTheme.horizontalPadding),
      children: [
        CustomSearchBarWidget(
          hintText: "Hinted search text",
          suffixIcon: SvgPicture.asset(Assets.filterIcon),
        ),
        20.ph,
        Row(
          spacing: 15,
          children: [
            Expanded(
              child: Container(
                height: 80.h,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.secondaryColor,
                ),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Product Sales",
                      style: context.textStyle.displayMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "123",
                            style: context.textStyle.displayLarge!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: " +6.5%",
                            style: context.textStyle.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.secondaryColor,
                ),
                child: Column(
                  spacing: 10,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Total Revenue",
                      style: context.textStyle.displayMedium!.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: "50000\$",
                            style: context.textStyle.displayLarge!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                          TextSpan(
                            text: " +6.5%",
                            style: context.textStyle.bodySmall!.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        10.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Product Sales", style: context.textStyle.displayMedium),
           PopupMenuButton<TimeFrame>(
  // Custom trigger widget
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 5.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.r),
      border: Border.all(color: AppColors.secondaryColor),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,  // ADDED: Prevent row from expanding
      children: [
        Text(
          _selectedTimeFrame.name.toTitleCase(),  // FIXED: Added comma
          style: context.textStyle.displayMedium,
        ),
        SizedBox(width: 3.w),  // CHANGED: Use SizedBox for spacing
        Padding(
          padding: EdgeInsets.only(bottom: 8.r),
          child: Transform.rotate(
            angle: 1.5 * 3.1416,  // 270° rotation
            child: Icon(
              Icons.arrow_back_ios,
              size: 18.r,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ],
    ),
  ),
  
  onSelected: (TimeFrame value) {  // SPECIFIED: Type parameter
    setState(() => _selectedTimeFrame = value);
  },
  
  itemBuilder: (BuildContext context) {
    return TimeFrame.values.map((TimeFrame frame) {  // CHANGED: Use map instead of generate
      return PopupMenuItem<TimeFrame>(
        value: frame,  // ADDED: Value parameter
        child: Text(frame.name.toTitleCase()),
      );
    }).toList();
  },
)
          ],
        ),
        20.ph,
        SizedBox(
          height: context.screenheight * 0.25,
          width: double.infinity,
          child: LineChart(_buildChartData()),
        ),
        20.ph,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Total Revenue", style: context.textStyle.displayMedium),
           PopupMenuButton<TimeFrame>(
  // Custom trigger widget
  child: Container(
    padding: EdgeInsets.symmetric(horizontal: 5.r),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.r),
      border: Border.all(color: AppColors.secondaryColor),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,  // ADDED: Prevent row from expanding
      children: [
        Text(
          _selectedTimeFrame.name.toTitleCase(),  // FIXED: Added comma
          style: context.textStyle.displayMedium,
        ),
        SizedBox(width: 3.w),  // CHANGED: Use SizedBox for spacing
        Padding(
          padding: EdgeInsets.only(bottom: 8.r),
          child: Transform.rotate(
            angle: 1.5 * 3.1416,  // 270° rotation
            child: Icon(
              Icons.arrow_back_ios,
              size: 18.r,
              color: AppColors.secondaryColor,
            ),
          ),
        ),
      ],
    ),
  ),
  
  onSelected: (TimeFrame value) {  // SPECIFIED: Type parameter
    // setState(() => _selectedTimeFrame = value);
  },
  
  itemBuilder: (BuildContext context) {
    return TimeFrame.values.map((TimeFrame frame) {  // CHANGED: Use map instead of generate
      return PopupMenuItem<TimeFrame>(
        value: frame,  // ADDED: Value parameter
        child: Text(frame.name.toTitleCase()),
      );
    }).toList();
  },
)
          ],
        ),
        20.ph,
        SizedBox(
          height: context.screenheight * 0.25,
          width: double.infinity,
          child: FinancialChart(),
        ),
      ],
    );
  }

  LineChartData _buildChartData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: _getYInterval(),
        getDrawingHorizontalLine: (value) {
          return FlLine(color: Colors.grey[300], strokeWidth: 1);
        },
        getDrawingVerticalLine: (value) {
          return FlLine(color: Colors.grey[300], strokeWidth: 1);
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50,
            interval: 1,
            getTitlesWidget: (value, meta) {
              return _getBottomTitleWidget(value);
            },
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: _getYInterval(),
            getTitlesWidget: (value, meta) {
              return _getLeftTitleWidget(value);
            },
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
        // border: Border.all(color: const Color(0xff37434d), width: 0),
      ),
      minX: 0,
      maxX: _getMaxX(),
      minY: 0,
      maxY: _getMaxY(),
      lineBarsData: [
        LineChartBarData(
          spots: _getDataPoints(),
          isCurved: true,
          color: AppColors.secondaryColor,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: true),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: [
                AppColors.secondaryColor.withOpacity(0.3),
                AppColors.secondaryColor.withOpacity(0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          // tooltipBgColor: Colors.blueAccent,
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((touchedSpot) {
              return LineTooltipItem(
                '\$${touchedSpot.y.toInt()}',
                const TextStyle(color: Colors.white),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  // Widget _buildTimeFrameButton(String label, TimeFrame timeframe) {
  //   return ElevatedButton(
  //     onPressed: () => setState(() => _selectedTimeFrame = timeframe),
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: _selectedTimeFrame == timeframe
  //           ? Colors.blue[700]
  //           : Colors.blue[100],
  //       foregroundColor: _selectedTimeFrame == timeframe
  //           ? Colors.white
  //           : Colors.blue[700],
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(20),
  //       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //     ),
  //     child: Text(label),
  //   );
  // }

  double _getMaxX() {
    switch (_selectedTimeFrame) {
      case TimeFrame.weekly:
        return 3;
      case TimeFrame.monthly:
        return 5;
      case TimeFrame.yearly:
        return 4;
    }
  }

  double _getMaxY() {
    switch (_selectedTimeFrame) {
      case TimeFrame.weekly:
        return 500;
      case TimeFrame.monthly:
        return 2500;
      case TimeFrame.yearly:
        return 25000;
    }
  }

  double _getYInterval() {
    switch (_selectedTimeFrame) {
      case TimeFrame.weekly:
        return 100;
      case TimeFrame.monthly:
        return 500;
      case TimeFrame.yearly:
        return 5000;
    }
  }

  List<FlSpot> _getDataPoints() {
    switch (_selectedTimeFrame) {
      case TimeFrame.weekly:
        return weeklyData;
      case TimeFrame.monthly:
        return monthlyData;
      case TimeFrame.yearly:
        return yearlyData;
    }
  }

  Widget _getBottomTitleWidget(double value) {
    String text;
    switch (_selectedTimeFrame) {
      case TimeFrame.weekly:
        text = 'Week ${value.toInt() + 1}';
        break;
      case TimeFrame.monthly:
        final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'];
        text = months[value.toInt()];
        break;
      case TimeFrame.yearly:
        text = (2020 + value.toInt()).toString();
        break;
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 8.r),
      child: Text(
        text,
        style: context.textStyle.bodySmall!.copyWith(color: Color(0xff5B5B5B)),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _getLeftTitleWidget(double value) {
    if (value % _getYInterval() != 0) {
      return const SizedBox.shrink();
    }

    String text;
    if (value >= 1000) {
      text = '${(value / 1000).toStringAsFixed(0)}k';
    } else {
      text = "${value.toInt()}";
    }

    return Padding(
      padding: EdgeInsets.only(right: 5.r),
      child: Text(
        text,
        style: context.textStyle.bodySmall!.copyWith(color: Color(0xff5B5B5B)),
        textAlign: TextAlign.left,
      ),
    );
  }
}

enum TimeFrame { weekly, monthly, yearly }
