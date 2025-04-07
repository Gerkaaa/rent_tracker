import 'package:flutter/material.dart';
import 'package:rent_tracker/core/constants/months.dart';
import 'package:rent_tracker/core/utils/date_utils.dart';
import 'package:rent_tracker/presentation/long_term_screen/widgets/long_term_apartment_card.dart';
import 'package:rent_tracker/presentation/widgets/custom_app_bar.dart';

class LongTermScreen extends StatefulWidget {
  const LongTermScreen({super.key});

  @override
  State<LongTermScreen> createState() => _LongTermScreenState();
}

class _LongTermScreenState extends State<LongTermScreen> {
  DateTime _currentMonth = DateTime(DateTime.now().year, DateTime.now().month);


// пока что
  final List<Map<String, dynamic>> apartments = [
    {
      'address': 'проспект Имама Шамиля, 42',
      'price': 30000,
      'payDay': 12,
      'responsible': null,
      'note': '',
      'isPaid': false,
    },
    {
      'address': 'ул. Ирчи Казака, 15',
      'price': 27000,
      'payDay': 10,
      'responsible': 'Иманат',
      'note': '',
      'isPaid': false,
    },
    {
      'address': 'ул. Ярагского, 8',
      'price': 32000,
      'payDay': 14,
      'responsible': 'Иманат',
      'note': '',
      'isPaid': false,
    },
  ];

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCFF),
        appBar: CustomAppBar(
          titleText: 'Долгий срок',
          currentMonth: _currentMonth,
          onSelectMonth: _showMonthPickerDialog,
          onAddPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Добавление квартиры')),
            );
          },
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: apartments.length,
          itemBuilder: (context, index) {
            final apt = apartments[index];
            return LongTermApartmentCard(
              apartment: apt,
              currentMonth: _currentMonth,
              onNoteChanged: (note) {
                setState(() {
                  apt['note'] = note;
                });
              },
              onPaidChanged: () {
                final monthText = formatMonth(_currentMonth);
                showDialog(
                  context: context,
                  builder:
                      (_) => AlertDialog(
                        title: const Text('Подтверждение'),
                        content: Text('Вам выплатили за $monthText?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Нет'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                apt['isPaid'] = true;
                              });
                              Navigator.pop(context);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Сдано: ${apt['address']}'),
                                ),
                              );
                            },
                            child: const Text('Да'),
                          ),
                        ],
                      ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
