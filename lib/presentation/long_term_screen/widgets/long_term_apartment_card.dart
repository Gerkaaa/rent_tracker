import 'package:flutter/material.dart';

class LongTermApartmentCard extends StatelessWidget {
  final Map<String, dynamic> apartment;
  final DateTime currentMonth;
  final VoidCallback onPaidChanged;
  final ValueChanged<String> onNoteChanged;

  const LongTermApartmentCard({
    super.key,
    required this.apartment,
    required this.currentMonth,
    required this.onPaidChanged,
    required this.onNoteChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isPaid = apartment['isPaid'] == true;
    final noteController = TextEditingController(text: apartment['note']);

    return Card(
      color: isPaid ? const Color(0xFFF0F0F0) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              apartment['address'],
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Сдаю за: ${apartment['price']} руб'),
            Text(
              'Оплата ожидается: приблизительно - ${apartment['payDay']} числа',
            ),
            if (apartment['responsible'] != null)
              Text('Ответственный: ${apartment['responsible']}'),
            const SizedBox(height: 12),
            const Text('Заметка:'),
            const SizedBox(height: 4),
            TextField(
              controller: noteController,
              maxLines: 2,
              onChanged: onNoteChanged,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      isPaid
                          ? const Color(0xFF34C759)
                          : const Color(0xFF1B72C0),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: isPaid ? () {} : onPaidChanged,
                child: Text(
                  isPaid ? 'Оплачено' : 'Ожидается оплата',
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
