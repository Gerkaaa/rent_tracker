import 'package:flutter/material.dart';
import 'package:rent_tracker/core/utils/date_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final VoidCallback? onAddPressed;
  final DateTime? currentMonth;
  final VoidCallback? onSelectMonth;

  const CustomAppBar({
    super.key,
    this.titleText,
    this.onAddPressed,
    this.currentMonth,
    this.onSelectMonth,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF3F4F9),
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 80,
      flexibleSpace: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [_buildTitleSection(), _buildAddButton()],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitleSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (titleText != null)
          Text(
            titleText!,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        const SizedBox(height: 4),
        if (currentMonth != null)
          GestureDetector(
            onTap: onSelectMonth,
            child: Row(
              children: [
                Text(
                  formatMonth(currentMonth!),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.calendar_month,
                  size: 18,
                  color: Color(0xFF1B72C0),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: onAddPressed,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Color(0xFF1B72C0),
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
