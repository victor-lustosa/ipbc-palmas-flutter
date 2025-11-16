import 'package:flutter/material.dart';

import '../../../core_module.dart';

mixin DateMixin {
   DateTime? startDate;
   DateTime? endDate;
   TimeOfDay? startTime;
   TimeOfDay? endTime;

  Future<void> setDateAndTime({
    required DateTime selectedDate,
    required TimeOfDay selectedTime,
    required Function(DateTime) onDatePicked,
    required BuildContext context,
  }) async {
    DateTime? pickedDate = await selectDateTime(
      selectedDate: selectedDate,
      context: context,
    );
    TimeOfDay? pickedTime;
    if (context.mounted) {
      pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (pickedDate != null && pickedTime != null) {
        onDatePicked(
          DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          ),
        );
      }
    }
  }

  DateTime nextWeekdayWithTime(
    DateTime from,
    int? targetWeekday,
    TimeOfDay? time,
  ) {
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

   Future<void> setDateTime({
     required DateTime selectedDate,
     required Function(DateTime) onDatePicked,
     required BuildContext context,
   }) async {
     final pickedDate = await selectDateTime(
       selectedDate: selectedDate,
       context: context,
     );
     if (pickedDate == null) return;

     final today = DateTime.now();
     final todayOnly = DateTime(today.year, today.month, today.day);
     final pickedOnly = DateTime(pickedDate.year, pickedDate.month, pickedDate.day);

     if (pickedOnly.isBefore(todayOnly)) {
       if (context.mounted) {
         showCustomMessageDialog(
           type: DialogType.error,
           context: context,
           title: 'Data inválida',
           message: 'Selecione uma data igual ou posterior a hoje.',
         );
       }
       return;
     }

     onDatePicked(pickedDate);
   }

   TimeOfDay parseTimeOfDayFromH(String timeString) {
    final parts = timeString.split('h');
    final hour = int.parse(parts[0]);
    final minute = (parts.length > 1 && parts[1].isNotEmpty)
        ? int.parse(parts[1])
        : 0;
    return TimeOfDay(hour: hour, minute: minute);
  }

  initDate({
    TimeOfDay? startTimeParam,
    TimeOfDay? endTimeParam,
    DateTime? startDateParam,
    DateTime? endDateParam,
  }) {
    final now = DateTime.now();
    startDate = startDateParam ?? (startDate ?? DateTime(now.year, now.month, now.day, 08, 0));
    endDate = endDateParam ?? (endDate ?? DateTime(now.year, now.month, now.day, 18, 0));
    startTime = startTimeParam ?? (startTime ?? TimeOfDay(hour: 08, minute: 00));
    endTime = endTimeParam ?? (endTime ?? TimeOfDay(hour: 18, minute: 30));
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

  String formatDateToString(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String formatHourToString({TimeOfDay? time, DateTime? date}) {
    if (date != null && time == null) {
      time = TimeOfDay(hour: date.hour, minute: date.minute);
    }
    final hour = time!.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    if (time.minute == 0) {
      return '${hour}h';
    }
    return '${hour}h$minute';
  }

   String capitalize(String text) {
     if (text.isEmpty) return text;
     return text[0].toUpperCase() + text.substring(1);
   }

   bool isSameDate(DateTime date1, DateTime date2) {
     return date1.year == date2.year &&
         date1.month == date2.month &&
         date1.day == date2.day;
   }

   String getFormattedDateTimeFull(
       DateTime dateTime, {
         bool isNotYear = false,
         bool isDateAndTime = false,
         bool isShortDate = false,
       }) {
     var weekday = DateFormat('EEE', 'pt_BR').format(dateTime);
     weekday = weekday.replaceAll('.', ''); // remove o ponto
     weekday = capitalize(weekday);

     final day = DateFormat('d', 'pt_BR').format(dateTime);

     var month = DateFormat('MMMM', 'pt_BR').format(dateTime);
     month = capitalize(month);

     final year = DateFormat('y', 'pt_BR').format(dateTime);

     if (isDateAndTime) {
       // Formato com hora e minuto -> 12 de Outubro às 19h ou 19h30
       final hour = DateFormat('HH', 'pt_BR').format(dateTime);
       final minute = DateFormat('mm', 'pt_BR').format(dateTime);

       final formattedTime = (minute == "00") ? "${hour}h" : "${hour}h$minute";
       return "$day de $month às $formattedTime";
     }

     if (isShortDate) {
       return "$day de $month";
     }

     if (isNotYear) {
       return "$weekday, $day de $month";
     }

     return "$weekday, $day de $month $year";
   }

}
