import 'package:flutter/material.dart';

class LongTermScreen extends StatelessWidget {
  const LongTermScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Долгий срок')),
      body: Center(child: Text('Экран долгосрочной аренды')),
    );
  }
}
