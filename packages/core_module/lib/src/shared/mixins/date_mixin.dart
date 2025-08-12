import 'package:flutter/material.dart';

import '../../../core_module.dart';

mixin DateMixin {
  late DateTime startDate;
  late DateTime endDate;
  late TimeOfDay startTime;
  late TimeOfDay endTime;

  DateTime nextWeekdayWithTime(DateTime from, int? targetWeekday, TimeOfDay? time) {
    int daysToAdd = ((targetWeekday ?? 6) - from.weekday) % 7;
    if (daysToAdd == 0) {
      daysToAdd = 7;
    }
    DateTime nextDate = from.add(Duration(days: daysToAdd));
    final TimeOfDay serviceTime = time ?? TimeOfDay(hour: 19, minute: 0);
    return DateTime(
      nextDate.year,
      nextDate.month,
      nextDate.day,
      serviceTime.hour,
      serviceTime.minute,
    );
  }

  TimeOfDay parseTimeOfDayFromH(String timeString) {
    final parts = timeString.split('h');
    final hour = int.parse(parts[0]);
    final minute = (parts.length > 1 && parts[1].isNotEmpty) ? int.parse(parts[1]) : 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  initDate({
    TimeOfDay? start,
    TimeOfDay? end,
    DateTime? startDateParam,
    DateTime? endDateParam,
  }) {
    final now = DateTime.now();
    startDate = startDateParam ?? DateTime(now.year, now.month, now.day, 8, 0);
    endDate = endDateParam ?? DateTime(now.year, now.month, now.day, 18, 0);
    startTime = start ?? TimeOfDay(hour: 08, minute: 00);
    endTime = end ?? TimeOfDay(hour: 18, minute: 30);
  }

  String formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '${hour}h$minute';
  }

  Future<void> pickTime({
    required TimeOfDay selectedTime,
    required Function(TimeOfDay) onTimePicked,
    required BuildContext context,
  }) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      onTimePicked(picked);
    }
  }

  Future<DateTime?> selectDateTime({
    required DateTime selectedDate,
    required BuildContext context,
  }) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
    );
    return pickedDate;
  }

  DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  String getFormattedDateTime(DateTime dateTime) {
    final formatter = DateFormat('EEE, d MMM yyyy', 'pt_BR');
    String formatted = formatter.format(dateTime);
    formatted = formatted.replaceAll('.', '');
    formatted = formatted
        .split(' ')
        .map((word) {
          if (word.isEmpty) return word;
          return word[0].toUpperCase() + word.substring(1);
        })
        .join(' ');
    return formatted;
  }
}
