import 'package:flutter/material.dart';
import 'package:rent_tracker/presentation/widgets/custom_app_bar.dart';

class AddLongTermApartmentScreen extends StatefulWidget {
  const AddLongTermApartmentScreen({super.key});

  @override
  State<AddLongTermApartmentScreen> createState() =>
      _AddLongTermApartmentScreenState();
}

class _AddLongTermApartmentScreenState
    extends State<AddLongTermApartmentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _priceController = TextEditingController();
  final _payDayController = TextEditingController();
  final _responsibleController = TextEditingController();

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      final newApartment = {
        'type': 'long_term',
        'address': _addressController.text.trim(),
        'price': int.tryParse(_priceController.text.trim()) ?? 0,
        'payDay': int.tryParse(_payDayController.text.trim()) ?? 1,
        'responsible':
            _responsibleController.text.trim().isEmpty
                ? null
                : _responsibleController.text.trim(),
        'note': '',
        'isPaid': false,
      };

      Navigator.pop(context, newApartment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: const Color(0xFFFCFCFF),
        appBar: const CustomAppBar(
          titleText: 'Добавить квартиру',
          hideAddButton: true,
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD3E4FF),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      'Вы добавляете квартиру, которая сдается на долгий срок',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildLabeledField(
                    'Адрес',
                    _addressController,
                    'Введите адрес',
                    icon: Icons.location_on,
                  ),
                  const SizedBox(height: 16),
                  _buildLabeledField(
                    'Сумма оплаты',
                    _priceController,
                    'Введите сумму',
                    keyboardType: TextInputType.number,
                    icon: Icons.money,
                  ),
                  const SizedBox(height: 16),
                  _buildLabeledField(
                    'День оплаты',
                    _payDayController,
                    'Приблизительное число',
                    keyboardType: TextInputType.number,
                    icon: Icons.calendar_month,
                  ),
                  const SizedBox(height: 16),
                  _buildLabeledField(
                    'Ответственный (если есть)',
                    _responsibleController,
                    null,
                    icon: Icons.person,
                  ),

                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1B72C0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Добавить',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledField(
    String label,
    TextEditingController controller,
    String? hintText, {
    TextInputType keyboardType = TextInputType.text,
    required IconData icon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(width: 6),
            Icon(icon, size: 22, color: const Color(0xFF1B72C0)),
          ],
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: (value) {
            if (hintText != null && (value == null || value.trim().isEmpty)) {
              return hintText;
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ],
    );
  }
}
