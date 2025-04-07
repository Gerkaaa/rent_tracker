import 'package:flutter/material.dart';
import 'package:rent_tracker/core/constants/months.dart';
import 'package:rent_tracker/presentation/widgets/custom_app_bar.dart';

class DailyScreen extends StatefulWidget {
  const DailyScreen({super.key});

  @override
  State<DailyScreen> createState() => _DailyScreenState();
}

class _DailyScreenState extends State<DailyScreen> {
  DateTime _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);

  final List<Map<String, dynamic>> managers = [
    {
      'name': 'Иманат',
      'apartments': [
        {'address': 'ул. Лаптиева, 10', 'price': 30000},
        {'address': 'пр. Акушинского, 88', 'price': 25000},
        {'address': 'ул. Петра I, 5', 'price': 27000},
      ],
      'payments': [
        {'amount': 30000, 'date': '01.04.2025'},
        {'amount': 20000, 'date': '05.04.2025'},
      ],
    },
    {
      'name': 'Амина',
      'apartments': [
        {'address': 'ул. Гагарина, 12', 'price': 40000},
        {'address': 'ул. Бейбулатова, 7', 'price': 32000},
      ],
      'payments': [
        {'amount': 50000, 'date': '03.04.2025'},
      ],
    },
  ];

  int _getTotal(List apartments) {
    return apartments.fold<int>(0, (sum, item) => sum + item['price'] as int);
  }

  int _getPaid(List payments) {
    return payments.fold<int>(0, (sum, item) => sum + item['amount'] as int);
  }

  void _showMonthPickerDialog() {
    final current = _currentMonth;
    final List<DateTime> visibleMonths = List.generate(7, (i) {
      return DateTime(current.year, current.month - 3 + i);
    });

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Выберите месяц',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: visibleMonths.length,
                itemBuilder: (context, index) {
                  final month = visibleMonths[index];
                  final isSelected =
                      month.year == current.year &&
                      month.month == current.month;

                  return ListTile(
                    leading:
                        isSelected
                            ? const Icon(Icons.check_circle, color: Colors.blue)
                            : const Icon(
                              Icons.circle_outlined,
                              color: Colors.grey,
                            ),
                    title: Text(
                      '${months[month.month - 1]} ${month.year}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.blue : Colors.black,
                      ),
                    ),
                    onTap: () {
                      setState(() {
                        _currentMonth = month;
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFCFCFF),
      appBar: CustomAppBar(
        titleText: 'Посуточные',
        currentMonth: _currentMonth,
        onSelectMonth: _showMonthPickerDialog,
        onAddPressed: () {},
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: managers.length,
        itemBuilder: (context, index) {
          final manager = managers[index];
          final apartments = manager['apartments'] as List;
          final payments = manager['payments'] as List;
          final total = _getTotal(apartments);
          final paid = _getPaid(payments);
          final left = total - paid;

          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            color: Colors.white,
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        manager['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Осталось: $left ₽',
                        style: const TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...apartments.map<Widget>(
                    (apt) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD3E4FF),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              apt['address'],
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF1B72C0),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${apt['price']} ₽',
                                style: const TextStyle(fontSize: 14),
                              ),
                              const SizedBox(width: 6),
                              const Icon(Icons.edit, size: 18),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Всего в месяц к оплате: $total руб.',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'Скинула: $paid руб.',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1B72C0),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 12,
                              horizontal: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Добавить поступление',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.history),
                        tooltip: 'История поступлений',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
