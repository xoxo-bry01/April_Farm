import 'package:flutter/material.dart';
import '../../../app_colours.dart';
import 'arena_diary_daily_view.dart';
import 'arena_diary_weekly_view.dart';
import 'arena_diary_monthly_view.dart';

class ArenaDiaryScreen extends StatelessWidget {
  const ArenaDiaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          title: const Text(
            'Arena Diary',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          bottom: const TabBar(
            indicatorColor: AppColors.primaryOrange,
            labelColor: AppColors.primaryOrange,
            unselectedLabelColor: AppColors.textSecondary,
            tabs: [
              Tab(text: 'Daily'),
              Tab(text: 'Weekly'),
              Tab(text: 'Monthly'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ArenaDiaryDailyView(),
            ArenaDiaryWeeklyView(),
            ArenaDiaryMonthlyView(),
          ],
        ),
      ),
    );
  }
}
