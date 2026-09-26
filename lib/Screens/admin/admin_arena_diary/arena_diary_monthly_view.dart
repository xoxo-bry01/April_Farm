import 'package:flutter/material.dart';
import '../../../app_colours.dart';

class ArenaDiaryMonthlyView extends StatelessWidget {
  const ArenaDiaryMonthlyView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Monthly Calendar Overview',
        style: TextStyle(color: AppColors.textPrimary, fontSize: 16),
      ),
    );
  }
}
