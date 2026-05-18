import 'package:consultz/core/constants/app_colors.dart';
import 'package:consultz/core/utils/responsive/screen.dart';
import 'package:consultz/core/utils/text/custom_text.dart';
import 'package:consultz/feature/expert/model/withdraw_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EarningChart extends StatelessWidget {
  const EarningChart({super.key, required this.overview, required this.total});

  final List<WithdrawOverview> overview;
  final double total;

  @override
  Widget build(BuildContext context) {
    double height = Screen.screenHeight(context);
    double width = Screen.screenWidth(context);
    double scaleFactor = width / Screen.designWidth;

    final spots = <FlSpot>[];
    for (int i = 0; i < overview.length; i++) {
      spots.add(FlSpot(i.toDouble(), overview[i].amount?.toDouble() ?? 0.0));
    }

    // Default gaps if overview is empty (though API should provide all months)
    if (spots.isEmpty) {
      spots.addAll(List.generate(12, (i) => FlSpot(i.toDouble(), 0)));
    }

    final maxAmount = overview.isEmpty 
        ? 100.0 
        : overview.map((e) => e.amount ?? 0).reduce((a, b) => a > b ? a : b).toDouble();

    return Padding(
      padding: EdgeInsets.all(scaleFactor * 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: 'This month earnings',
            color: AppColors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w400,
          ),
          CustomText(
            text: '£${total.toStringAsFixed(2)}',
            color: AppColors.black,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: height * 0.01),
          SizedBox(
            height: height * 0.2,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: true, drawVerticalLine: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: width * 0.1,
                      getTitlesWidget: (value, meta) {
                        return CustomText(
                          text: '£${value.toInt()}',
                          color: AppColors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        );
                      },
                    ),
                  ),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        int index = value.toInt();
                        if (index >= 0 && index < overview.length) {
                          return Padding(
                            padding: EdgeInsets.only(top: scaleFactor * 6),
                            child: CustomText(
                              text: overview[index].month?.toUpperCase() ?? '',
                              color: AppColors.grey,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                          );
                        }
                        return SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.primaryColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFCDAFD8),
                          Color(0xFFCDAFD8).withValues(alpha: 0.08),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
                minY: 0,
                maxY: maxAmount > 0 ? maxAmount * 1.2 : 100,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
