import 'package:flutter/material.dart';
import 'package:rent_tracker/core/utils/date_utils.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? titleText;
  final VoidCallback? onAddPressed;
  final DateTime? currentMonth;
  final VoidCallback? onSelectMonth;
  final bool hideAddButton;

  const CustomAppBar({
    super.key,
    this.titleText,
    this.onAddPressed,
    this.currentMonth,
    this.onSelectMonth,
    this.hideAddButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF3F4F9),
      elevation: 0,
      automaticallyImplyLeading: true,
      leadingWidth: 30,
      toolbarHeight: 80,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
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
          if (currentMonth != null)
            GestureDetector(
              onTap: onSelectMonth,
              child: Row(
                children: [
                  Text(
                    formatMonth(currentMonth!),
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  const SizedBox(width: 10),
                  const Icon(
                    Icons.calendar_month,
                    size: 18,
                    color: Color(0xFF1B72C0),
                  ),
                ],
              ),
            ),
        ],
      ),
      actions: [
        if (!hideAddButton)
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
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
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
