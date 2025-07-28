import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:push_price_manager/export_all.dart';
import 'package:push_price_manager/utils/extension.dart';

class FinancialChart extends StatelessWidget {
  const FinancialChart({super.key});

  @override
  Widget build(BuildContext context) {
    return  BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: 50000,
        minY: 0,
        groupsSpace: 20,
        barTouchData: BarTouchData(enabled: false),
        titlesData: FlTitlesData(
          show: true,
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 55,
              getTitlesWidget: (value, meta) {
                return _leftTitleWidget(value,context);
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (value) => FlLine(
            color: Colors.grey[300],
            strokeWidth: 1,
          ),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          BarChartGroupData(
            x: 0,
            groupVertically: true,
            barRods: [
              BarChartRodData(
                toY: 50000,
                width: 30,
                color: AppColors.secondaryColor.withValues(alpha: 0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
               BarChartRodData(
                toY: 20000,
                width: 30,
                color: AppColors.secondaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 1,
            groupVertically: true,
            barRods: [
              BarChartRodData(
                toY: 50000,
                width: 30,
                color: AppColors.secondaryColor.withValues(alpha: 0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
               BarChartRodData(
                toY: 40000,
                width: 30,
                color: AppColors.secondaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 2,
            groupVertically: true,
            barRods: [
              BarChartRodData(
                toY: 50000,
                width: 30,
                color: AppColors.secondaryColor.withValues(alpha: 0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
               BarChartRodData(
                toY: 30000,
                width: 30,
                color: AppColors.secondaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
            ],
          ),
          BarChartGroupData(
            x: 3,
            groupVertically: true,
            barRods: [
              BarChartRodData(
                toY: 50000,
                width: 30,
                color: AppColors.secondaryColor.withValues(alpha: 0.4),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
               BarChartRodData(
                toY: 20000,
                width: 30,
                color: AppColors.secondaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
              ),
            ],
          ),
         
        ],
      ),
    );
  }

  Widget _leftTitleWidget(double value, BuildContext context) {
   
    String text;
    switch (value.toInt()) {
      case 10000:
        text = '10000\$';
        break;
      case 20000:
        text = '20000\$';
        break;
      case 30000:
        text = '30000\$';
        break;
      case 40000:
        text = '40000\$';
        break;
      case 50000:
        text = '50000\$';
        break;
      default:
        return Container();
    }
    
    return Padding(
      padding: EdgeInsets.only(right: 5.r, left: 0),
      child: Text(
        text,
        style: context.textStyle.bodySmall!.copyWith(color: Color(0xff5B5B5B)),
        textAlign: TextAlign.left
      ),
    );
  }
}