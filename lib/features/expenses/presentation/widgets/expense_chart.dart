// lib/features/expenses/presentation/widgets/expense_chart.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/currency_formatter.dart';

class ExpenseChart extends StatefulWidget {
  final Map<String, double> categoryAmounts;
  final String currency;

  const ExpenseChart({
    super.key,
    required this.categoryAmounts,
    this.currency = 'INR',
  });

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    if (widget.categoryAmounts.isEmpty) {
      return const Center(child: Text('No expenses yet.'));
    }

    final total = widget.categoryAmounts.values.fold(0.0, (a, b) => a + b);

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      touchedIndex = -1;
                      return;
                    }
                    touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                  });
                },
              ),
              borderData: FlBorderData(show: false),
              sectionsSpace: 2,
              centerSpaceRadius: 40,
              sections: _showingSections(total),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          alignment: WrapAlignment.center,
          children: widget.categoryAmounts.entries.map((e) {
            final isTouched = widget.categoryAmounts.keys.toList().indexOf(e.key) == touchedIndex;
            return _Legend(
              color: _getCategoryColor(e.key),
              text: e.key,
              amount: CurrencyFormatter.formatCompact(e.value, currency: widget.currency),
              isBold: isTouched,
            );
          }).toList(),
        ),
      ],
    );
  }

  List<PieChartSectionData> _showingSections(double total) {
    return List.generate(widget.categoryAmounts.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 20.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      final entry = widget.categoryAmounts.entries.toList()[i];
      final percentage = (entry.value / total) * 100;

      return PieChartSectionData(
        color: _getCategoryColor(entry.key),
        value: entry.value,
        title: '${percentage.toStringAsFixed(0)}%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    });
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food': return Colors.orange;
      case 'transport': return Colors.blue;
      case 'hotel': return Colors.purple;
      case 'activity': return Colors.green;
      case 'shopping': return Colors.pink;
      default: return Colors.grey;
    }
  }
}

class _Legend extends StatelessWidget {
  final Color color;
  final String text;
  final String amount;
  final bool isBold;

  const _Legend({
    required this.color,
    required this.text,
    required this.amount,
    required this.isBold,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 4),
        Text(
          '$text ($amount)',
          style: TextStyle(
            fontSize: 12,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          ),
        )
      ],
    );
  }
}
