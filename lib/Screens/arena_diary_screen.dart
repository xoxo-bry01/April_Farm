import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_colours.dart';
import '../providers/booking_provider.dart';
import '../models/booking.dart';

class ArenaDiaryScreen extends StatefulWidget {
  const ArenaDiaryScreen({super.key});

  @override
  State<ArenaDiaryScreen> createState() => _ArenaDiaryScreenState();
}

enum CalendarViewMode { month, year, overview }

class _ArenaDiaryScreenState extends State<ArenaDiaryScreen> {
  DateTime _focusedMonth = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  CalendarViewMode _viewMode = CalendarViewMode.month;

  // Session Brief Bottom Sheet modal
  void _showSessionPrepBrief(BuildContext context, Booking booking) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardSurface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Session Preparation Brief',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: booking.status == 'Paid'
                          ? Colors.green.withOpacity(0.2)
                          : Colors.amber.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      booking.status.toUpperCase(),
                      style: TextStyle(
                        color: booking.status == 'Paid'
                            ? Colors.green
                            : Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: AppColors.primaryOrange,
                  child: Icon(Icons.pets, color: Colors.white),
                ),
                title: Text(
                  booking.customerName,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                subtitle: Text(
                  booking.serviceName,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ),
              const Divider(color: AppColors.background, height: 24),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    color: AppColors.primaryOrange,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${booking.date.day}/${booking.date.month}/${booking.date.year}',
                    style: const TextStyle(color: AppColors.textPrimary),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Preparation & Special Notes:',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 6),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Verify rider equipment and ensure arena surface is prepped prior to arrival.',
                  style: TextStyle(color: AppColors.textPrimary, fontSize: 13),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryOrange,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text(
                    'Close Brief',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bookingProvider = Provider.of<BookingProvider>(context);
    final allBookings = bookingProvider.allBookings;

    final selectedDayBookings = allBookings.where((b) {
      return b.date.year == _selectedDate.year &&
          b.date.month == _selectedDate.month &&
          b.date.day == _selectedDate.day;
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Arena Diary',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(4),
                child: Row(
                  children: [
                    _buildSegmentButton('Month', CalendarViewMode.month),
                    _buildSegmentButton('Year View', CalendarViewMode.year),
                    _buildSegmentButton('Overview', CalendarViewMode.overview),
                  ],
                ),
              ),
            ),

            if (_viewMode == CalendarViewMode.month) ...[
              _buildMonthHeader(),
              _buildDaysOfWeekHeader(),
              _buildCalendarGrid(allBookings),
              const Divider(color: AppColors.cardSurface, height: 1),
              Expanded(child: _buildSelectedDayEvents(selectedDayBookings)),
            ] else if (_viewMode == CalendarViewMode.year) ...[
              Expanded(child: _build12MonthYearGrid(allBookings)),
            ] else if (_viewMode == CalendarViewMode.overview) ...[
              Expanded(child: _buildEquestrianOverviewTab(allBookings)),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSegmentButton(String label, CalendarViewMode mode) {
    final isSelected = _viewMode == mode;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _viewMode = mode),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryOrange : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textSecondary,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMonthHeader() {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: AppColors.textPrimary),
            onPressed: () {
              setState(() {
                _focusedMonth = DateTime(
                  _focusedMonth.year,
                  _focusedMonth.month - 1,
                );
              });
            },
          ),
          Text(
            '${months[_focusedMonth.month - 1]} ${_focusedMonth.year}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: AppColors.textPrimary),
            onPressed: () {
              setState(() {
                _focusedMonth = DateTime(
                  _focusedMonth.year,
                  _focusedMonth.month + 1,
                );
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDaysOfWeekHeader() {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: days
            .map(
              (d) => SizedBox(
                width: 40,
                child: Text(
                  d,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildCalendarGrid(List<Booking> allBookings) {
    final daysInMonth = DateUtils.getDaysInMonth(
      _focusedMonth.year,
      _focusedMonth.month,
    );
    final firstDayOffset =
        DateTime(_focusedMonth.year, _focusedMonth.month, 1).weekday - 1;

    final today = DateTime.now();

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        childAspectRatio: 1.1,
      ),
      itemCount: daysInMonth + firstDayOffset,
      itemBuilder: (context, index) {
        if (index < firstDayOffset) {
          return const SizedBox.shrink();
        }

        final dayNumber = index - firstDayOffset + 1;
        final cellDate = DateTime(
          _focusedMonth.year,
          _focusedMonth.month,
          dayNumber,
        );

        final isToday =
            cellDate.year == today.year &&
            cellDate.month == today.month &&
            cellDate.day == today.day;

        final isSelected =
            cellDate.year == _selectedDate.year &&
            cellDate.month == _selectedDate.month &&
            cellDate.day == _selectedDate.day;

        final dayEvents = allBookings
            .where(
              (b) =>
                  b.date.year == cellDate.year &&
                  b.date.month == cellDate.month &&
                  b.date.day == cellDate.day,
            )
            .toList();

        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedDate = cellDate;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: isSelected
                  ? AppColors.primaryOrange.withOpacity(0.2)
                  : AppColors.cardSurface,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? AppColors.primaryOrange
                    : isToday
                    ? Colors.amber
                    : Colors.transparent,
                width: isSelected || isToday ? 1.5 : 0,
              ),
            ),
            padding: const EdgeInsets.all(2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '$dayNumber',
                  style: TextStyle(
                    color: isToday
                        ? AppColors.primaryOrange
                        : AppColors.textPrimary,
                    fontWeight: isToday || isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                if (dayEvents.isNotEmpty)
                  Column(
                    children: dayEvents.take(2).map((e) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 2),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 2,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryOrange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          e.serviceName.split(' ')[0],
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _build12MonthYearGrid(List<Booking> allBookings) {
    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
      ),
      itemCount: 12,
      itemBuilder: (context, monthIndex) {
        final monthNum = monthIndex + 1;
        final monthName = months[monthIndex];
        final daysInMonth = DateUtils.getDaysInMonth(2026, monthNum);

        return GestureDetector(
          onTap: () {
            setState(() {
              _focusedMonth = DateTime(2026, monthNum);
              _viewMode = CalendarViewMode.month;
            });
          },
          child: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  monthName,
                  style: const TextStyle(
                    color: AppColors.primaryOrange,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 7,
                        ),
                    itemCount: daysInMonth,
                    itemBuilder: (ctx, dayIdx) {
                      final dayNum = dayIdx + 1;
                      final hasEvent = allBookings.any(
                        (b) =>
                            b.date.year == 2026 &&
                            b.date.month == monthNum &&
                            b.date.day == dayNum,
                      );

                      return Center(
                        child: Text(
                          '$dayNum',
                          style: TextStyle(
                            fontSize: 8,
                            color: hasEvent
                                ? AppColors.primaryOrange
                                : AppColors.textSecondary,
                            fontWeight: hasEvent
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildEquestrianOverviewTab(List<Booking> allBookings) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Active Scheduled Horses',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            Row(
              children: [
                Text(
                  'Yesterday  ',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'Today  ',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
                Text(
                  'Tomorrow',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        if (allBookings.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32.0),
            child: Center(
              child: Text(
                'No bookings recorded yet.',
                style: TextStyle(color: AppColors.textSecondary),
              ),
            ),
          )
        else
          ...allBookings.map((booking) {
            final today = DateTime.now();
            final isToday =
                booking.date.year == today.year &&
                booking.date.month == today.month &&
                booking.date.day == today.day;

            return GestureDetector(
              onTap: () => _showSessionPrepBrief(context, booking),
              child: Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 16,
                          backgroundColor: AppColors.primaryOrange,
                          child: Icon(
                            Icons.pets,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              booking.customerName,
                              style: const TextStyle(
                                color: AppColors.textPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              booking.serviceName,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _buildStatusIndicator(!isToday, Colors.amber),
                        const SizedBox(width: 24),
                        _buildStatusIndicator(isToday, AppColors.primaryOrange),
                        const SizedBox(width: 24),
                        _buildStatusIndicator(!isToday, Colors.blueAccent),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }

  Widget _buildStatusIndicator(bool active, Color color) {
    return Container(
      width: 16,
      height: 4,
      decoration: BoxDecoration(
        color: active ? color : Colors.transparent,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildSelectedDayEvents(List<Booking> bookings) {
    if (bookings.isEmpty) {
      return const Center(
        child: Text(
          'No activities for this date.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: bookings.length,
      itemBuilder: (context, index) {
        final booking = bookings[index];
        return GestureDetector(
          onTap: () => _showSessionPrepBrief(context, booking),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.cardSurface,
              borderRadius: BorderRadius.circular(16),
              border: Border(
                left: BorderSide(
                  color: booking.status == 'Paid'
                      ? AppColors.primaryOrange
                      : Colors.amber,
                  width: 4,
                ),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.event_note, color: AppColors.primaryOrange),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.serviceName,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Rider / Horse: ${booking.customerName}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primaryOrange.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    booking.status,
                    style: const TextStyle(
                      color: AppColors.primaryOrange,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
