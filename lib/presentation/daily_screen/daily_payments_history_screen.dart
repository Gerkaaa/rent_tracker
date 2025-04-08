import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rent_tracker/presentation/widgets/custom_app_bar.dart';

class DailyPaymentsHistoryScreen extends StatelessWidget {
  final String managerName;
  final List<Map<String, dynamic>> payments;

  const DailyPaymentsHistoryScreen({
    super.key,
    required this.managerName,
    required this.payments,
  });

  String _formatDate(String rawDate) {
    final date = DateFormat('dd.MM.yyyy').parse(rawDate);
    return DateFormat('d MMMM yyyy', 'ru').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final sortedPayments = payments.reversed.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFF),
      appBar: CustomAppBar(
        titleText: 'История платежей — $managerName',
        hideAddButton: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: sortedPayments.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final payment = sortedPayments[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFE1F3E4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(payment['date']),
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  '${payment['amount']} ₽',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
