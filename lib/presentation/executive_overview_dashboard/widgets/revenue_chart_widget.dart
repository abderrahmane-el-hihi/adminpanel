import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_icon_widget.dart';

class RevenueChartWidget extends StatefulWidget {
  final List<Map<String, dynamic>> revenueData;
  final List<Map<String, dynamic>> productivityData;
  final VoidCallback? onExport;

  const RevenueChartWidget({
    super.key,
    required this.revenueData,
    required this.productivityData,
    this.onExport,
  });

  @override
  State<RevenueChartWidget> createState() => _RevenueChartWidgetState();
}

class _RevenueChartWidgetState extends State<RevenueChartWidget> {
  bool _showProductivity = true;
  int _touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
        width: double.infinity,
        constraints: BoxConstraints(minHeight: 35.h, maxHeight: 45.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.1),
                  offset: const Offset(0, 2),
                  blurRadius: 8,
                  spreadRadius: 0),
            ]),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  Text('Revenue & Productivity Trends',
                      style: theme.textTheme.titleLarge?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w600),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis),
                  SizedBox(height: 0.5.h),
                  Text('Monthly performance overview',
                      style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.6))),
                ])),
            Row(children: [
              GestureDetector(
                  onTap: () {
                    setState(() {
                      _showProductivity = !_showProductivity;
                    });
                  },
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                      decoration: BoxDecoration(
                          color: _showProductivity
                              ? colorScheme.primary.withValues(alpha: 0.1)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                              color: colorScheme.outline.withValues(alpha: 0.3),
                              width: 1)),
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        CustomIconWidget(
                            iconName: 'show_chart',
                            color: _showProductivity
                                ? colorScheme.primary
                                : colorScheme.onSurface.withValues(alpha: 0.6),
                            size: 16),
                        SizedBox(width: 1.w),
                        Text('Productivity',
                            style: theme.textTheme.bodySmall?.copyWith(
                                color: _showProductivity
                                    ? colorScheme.primary
                                    : colorScheme.onSurface
                                        .withValues(alpha: 0.6),
                                fontWeight: FontWeight.w500)),
                      ]))),
              SizedBox(width: 2.w),
              GestureDetector(
                  onTap: widget.onExport,
                  child: Container(
                      padding: EdgeInsets.all(2.w),
                      decoration: BoxDecoration(
                          color: colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6)),
                      child: CustomIconWidget(
                          iconName: 'file_download',
                          color: colorScheme.primary,
                          size: 20))),
            ]),
          ]),
          SizedBox(height: 3.h),
          Expanded(
              child: LineChart(LineChartData(
                  gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 50000,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                            color: colorScheme.outline.withValues(alpha: 0.2),
                            strokeWidth: 1);
                      }),
                  titlesData: FlTitlesData(
                      show: true,
                      rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false)),
                      bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              interval: 1,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                const months = [
                                  'Jan',
                                  'Feb',
                                  'Mar',
                                  'Apr',
                                  'May',
                                  'Jun'
                                ];
                                if (value.toInt() >= 0 &&
                                    value.toInt() < months.length) {
                                  return SideTitleWidget(
                                      axisSide: meta.axisSide,
                                      child: Text(months[value.toInt()],
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                  color: colorScheme.onSurface
                                                      .withValues(
                                                          alpha: 0.6))));
                                }
                                return const Text('');
                              })),
                      leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                              showTitles: true,
                              interval: 100000,
                              reservedSize: 60,
                              getTitlesWidget: (double value, TitleMeta meta) {
                                return SideTitleWidget(
                                    axisSide: meta.axisSide,
                                    child: Text('\$${(value / 1000).toInt()}K',
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                                color: colorScheme.onSurface
                                                    .withValues(alpha: 0.6))));
                              }))),
                  borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                          color: colorScheme.outline.withValues(alpha: 0.2),
                          width: 1)),
                  minX: 0,
                  maxX: 5,
                  minY: 0,
                  maxY: 500000,
                  lineBarsData: [
                    // Revenue line
                    LineChartBarData(
                        spots: widget.revenueData.asMap().entries.map((entry) {
                          return FlSpot(entry.key.toDouble(),
                              (entry.value['amount'] as num).toDouble());
                        }).toList(),
                        isCurved: true,
                        gradient: LinearGradient(colors: [
                          colorScheme.primary,
                          colorScheme.primary.withValues(alpha: 0.8),
                        ]),
                        barWidth: 3,
                        isStrokeCapRound: true,
                        dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, barData, index) {
                              return FlDotCirclePainter(
                                  radius: _touchedIndex == index ? 6 : 4,
                                  color: colorScheme.primary,
                                  strokeWidth: 2,
                                  strokeColor: colorScheme.surface);
                            }),
                        belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                                colors: [
                                  colorScheme.primary.withValues(alpha: 0.2),
                                  colorScheme.primary.withValues(alpha: 0.05),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter))),
                    // Productivity line (if enabled)
                    if (_showProductivity)
                      LineChartBarData(
                          spots: widget.productivityData
                              .asMap()
                              .entries
                              .map((entry) {
                            return FlSpot(
                                entry.key.toDouble(),
                                (entry.value['score'] as num).toDouble() *
                                    5000);
                          }).toList(),
                          isCurved: true,
                          color: colorScheme.secondary,
                          barWidth: 2,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) {
                                return FlDotCirclePainter(
                                    radius: 3,
                                    color: colorScheme.secondary,
                                    strokeWidth: 1,
                                    strokeColor: colorScheme.surface);
                              }),
                          dashArray: [5, 5]),
                  ],
                  lineTouchData: LineTouchData(
                      enabled: true,
                      touchCallback: (FlTouchEvent event,
                          LineTouchResponse? touchResponse) {
                        setState(() {
                          if (touchResponse != null &&
                              touchResponse.lineBarSpots != null) {
                            _touchedIndex =
                                touchResponse.lineBarSpots!.first.spotIndex;
                          } else {
                            _touchedIndex = -1;
                          }
                        });
                      },
                      getTouchedSpotIndicator:
                          (LineChartBarData barData, List<int> spotIndexes) {
                        return spotIndexes.map((spotIndex) {
                          return TouchedSpotIndicatorData(
                              FlLine(
                                  color: colorScheme.primary
                                      .withValues(alpha: 0.5),
                                  strokeWidth: 2,
                                  dashArray: [3, 3]),
                              FlDotData(getDotPainter:
                                  (spot, percent, barData, index) {
                            return FlDotCirclePainter(
                                radius: 6,
                                color: colorScheme.primary,
                                strokeWidth: 2,
                                strokeColor: colorScheme.surface);
                          }));
                        }).toList();
                      },
                      touchTooltipData: LineTouchTooltipData(
                          tooltipRoundedRadius: 8,
                          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                            return touchedBarSpots.map((barSpot) {
                              final flSpot = barSpot;
                              const months = [
                                'Jan',
                                'Feb',
                                'Mar',
                                'Apr',
                                'May',
                                'Jun'
                              ];
                              final month = months[flSpot.x.toInt()];

                              if (barSpot.barIndex == 0) {
                                return LineTooltipItem(
                                    '$month\nRevenue: \${(flSpot.y / 1000).toInt()}K',
                                    TextStyle(
                                        color: colorScheme.onInverseSurface,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12));
                              } else {
                                return LineTooltipItem(
                                    'Productivity: ${(flSpot.y / 5000).toInt()}%',
                                    TextStyle(
                                        color: colorScheme.secondary,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12));
                              }
                            }).toList();
                          }))))),
          SizedBox(height: 2.h),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            _buildLegendItem(context, 'Revenue', colorScheme.primary, false),
            SizedBox(width: 4.w),
            if (_showProductivity)
              _buildLegendItem(
                  context, 'Productivity', colorScheme.secondary, true),
          ]),
        ]));
  }

  Widget _buildLegendItem(
      BuildContext context, String label, Color color, bool isDashed) {
    final theme = Theme.of(context);

    return Row(mainAxisSize: MainAxisSize.min, children: [
      Container(
          width: 16,
          height: 3,
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(2)),
          child: isDashed
              ? CustomPaint(painter: DashedLinePainter(color: color))
              : null),
      SizedBox(width: 2.w),
      Text(label,
          style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              fontWeight: FontWeight.w500)),
    ]);
  }
}

class DashedLinePainter extends CustomPainter {
  final Color color;

  DashedLinePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    const dashWidth = 3.0;
    const dashSpace = 2.0;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(Offset(startX, size.height / 2),
          Offset(startX + dashWidth, size.height / 2), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}