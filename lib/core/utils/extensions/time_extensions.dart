import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeFormatter {
  /// Converts ASCII digits (0-9) to Eastern Arabic Numerals (٠-٩).
  static String toArabicDigits(String input) {
    const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const ar = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    String res = input;
    for (int i = 0; i < 10; i++) {
      res = res.replaceAll(en[i], ar[i]);
    }
    return res;
  }

  /// Converts Eastern Arabic Numerals (٠-٩) to ASCII digits (0-9).
  static String toAsciiDigits(String input) {
    const ar = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];
    const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    String res = input;
    for (int i = 0; i < 10; i++) {
      res = res.replaceAll(ar[i], en[i]);
    }
    return res;
  }

  static const Map<String, String> _monthTranslations = {
    'January': 'يناير',
    'February': 'فبراير',
    'March': 'مارس',
    'April': 'أبريل',
    'May': 'مايو',
    'June': 'يونيو',
    'July': 'يوليو',
    'August': 'أغسطس',
    'September': 'سبتمبر',
    'October': 'أكتوبر',
    'November': 'نوفمبر',
    'December': 'ديسمبر',
    'Jan': 'يناير',
    'Feb': 'فبراير',
    'Mar': 'مارس',
    'Apr': 'أبريل',
    'Jun': 'يونيو',
    'Jul': 'يوليو',
    'Aug': 'أغسطس',
    'Sep': 'سبتمبر',
    'Sept': 'سبتمبر',
    'Oct': 'أكتوبر',
    'Nov': 'نوفمبر',
    'Dec': 'ديسمبر',
  };

  static const Map<String, String> _dayTranslations = {
    'Saturday': 'السبت',
    'Sunday': 'الأحد',
    'Monday': 'الإثنين',
    'Tuesday': 'الثلاثاء',
    'Wednesday': 'الأربعاء',
    'Thursday': 'الخميس',
    'Friday': 'الجمعة',
    'Sat': 'السبت',
    'Sun': 'الأحد',
    'Mon': 'الإثنين',
    'Tue': 'الثلاثاء',
    'Wed': 'الأربعاء',
    'Thu': 'الخميس',
    'Fri': 'الجمعة',
  };

  /// Localizes any English month and day names into Arabic.
  static String localizeMonthAndDayNames(String input) {
    String res = input;
    _monthTranslations.forEach((en, ar) {
      res = res.replaceAll(
        RegExp(r'\b' + en + r'\b', caseSensitive: false),
        ar,
      );
    });
    _dayTranslations.forEach((en, ar) {
      res = res.replaceAll(
        RegExp(r'\b' + en + r'\b', caseSensitive: false),
        ar,
      );
    });
    return res;
  }

  /// Converts any time string (24h, 12h, ISO datetime) into 12-hour format with AM/PM (or ص/م in Arabic) and localized digits.
  static String formatTo12Hour(
    String? timeStr, {
    BuildContext? context,
    String? locale,
  }) {
    if (timeStr == null || timeStr.trim().isEmpty) return '';
    final trimmed = timeStr.trim();
    final normalized = toAsciiDigits(trimmed);

    final resolvedLocale =
        locale ??
        (context != null
            ? Localizations.localeOf(context).languageCode
            : (Intl.defaultLocale?.startsWith('ar') == true ? 'ar' : 'en'));
    final isArabic = resolvedLocale == 'ar';

    String formatResult(int hour12, String minute, String amPm) {
      final paddedHour = hour12.toString().padLeft(2, '0');
      String period;
      if (isArabic) {
        period = (amPm == 'PM' || amPm == 'م') ? 'م' : 'ص';
      } else {
        period = (amPm == 'PM' || amPm == 'م') ? 'PM' : 'AM';
      }
      final result = '$paddedHour:$minute $period';
      return isArabic ? toArabicDigits(result) : result;
    }

    // 1. If already in 12-hour format: e.g. "9:00 AM", "09:00 AM", "09:00:00 AM", "9:00 ص", "9:00 م"
    final amPmRegex = RegExp(
      r'^(\d{1,2}):(\d{2})(?::(\d{2}))?\s*(AM|PM|am|pm|ص|م)$',
    );
    final amPmMatch = amPmRegex.firstMatch(normalized);
    if (amPmMatch != null) {
      final hour = int.tryParse(amPmMatch.group(1)!) ?? 0;
      final minute = amPmMatch.group(2)!;
      final rawPeriod = amPmMatch.group(4)!;
      String period = rawPeriod.toUpperCase();
      if (rawPeriod == 'ص') period = 'AM';
      if (rawPeriod == 'م') period = 'PM';

      final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
      return formatResult(hour12, minute, period);
    }

    // 2. 24-hour time format: e.g. "14:30", "14:30:00", "9:30", "09:30:00", "00:00", "0:00"
    final time24Regex = RegExp(r'^(\d{1,2}):(\d{2})(?::(\d{2}))?$');
    final time24Match = time24Regex.firstMatch(normalized);
    if (time24Match != null) {
      final hour24 = int.tryParse(time24Match.group(1)!) ?? 0;
      final minute = time24Match.group(2)!;
      final period = hour24 >= 12 ? 'PM' : 'AM';
      final hour12 = hour24 == 0 ? 12 : (hour24 > 12 ? hour24 - 12 : hour24);
      return formatResult(hour12, minute, period);
    }

    // 3. Full ISO or Date-time string: e.g. "2026-02-06T14:30:00" or "2026-02-06 14:30:00"
    final parsed = DateTime.tryParse(normalized);
    if (parsed != null) {
      final local = parsed.toLocal();
      final hour24 = local.hour;
      final minute = local.minute.toString().padLeft(2, '0');
      final period = hour24 >= 12 ? 'PM' : 'AM';
      final hour12 = hour24 == 0 ? 12 : (hour24 > 12 ? hour24 - 12 : hour24);
      return formatResult(hour12, minute, period);
    }

    // 4. Try DateFormat parsers as fallback
    try {
      final dt = DateFormat('HH:mm:ss').parse(normalized);
      final res = DateFormat('hh:mm a', resolvedLocale).format(dt);
      return isArabic ? toArabicDigits(res) : res;
    } catch (_) {
      try {
        final dt = DateFormat('HH:mm').parse(normalized);
        final res = DateFormat('hh:mm a', resolvedLocale).format(dt);
        return isArabic ? toArabicDigits(res) : res;
      } catch (_) {
        if (isArabic) {
          final res = trimmed
              .replaceAll(RegExp(r'\bAM\b', caseSensitive: false), 'ص')
              .replaceAll(RegExp(r'\bPM\b', caseSensitive: false), 'م');
          return toArabicDigits(res);
        }
        final res = trimmed.replaceAll('ص', 'AM').replaceAll('م', 'PM');
        return toAsciiDigits(res);
      }
    }
  }

  /// Formats date localized for Arabic and English with localized digits and localized months.
  static String formatDate(
    dynamic dateInput, {
    BuildContext? context,
    String? locale,
    String? pattern,
  }) {
    if (dateInput == null) return '';
    final resolvedLocale =
        locale ??
        (context != null
            ? Localizations.localeOf(context).languageCode
            : (Intl.defaultLocale?.startsWith('ar') == true ? 'ar' : 'en'));
    final isArabic = resolvedLocale == 'ar';

    if (dateInput is DateTime) {
      final p = pattern ?? 'yyyy-MM-dd';
      final formatted = DateFormat(
        p,
        resolvedLocale,
      ).format(dateInput.toLocal());
      return isArabic ? toArabicDigits(formatted) : formatted;
    }

    final dateStr = dateInput.toString();
    if (dateStr.trim().isEmpty) return '';
    final trimmed = dateStr.trim();

    final lower = trimmed.toLowerCase();
    if (lower == 'tomorrow' || trimmed == 'غداً' || trimmed == 'غدا') {
      return isArabic ? 'غداً' : 'Tomorrow';
    }
    if (lower == 'today' || trimmed == 'اليوم') {
      return isArabic ? 'اليوم' : 'Today';
    }
    if (lower == 'yesterday' || trimmed == 'أمس') {
      return isArabic ? 'أمس' : 'Yesterday';
    }

    final normalized = toAsciiDigits(trimmed);
    final parsedDate = DateTime.tryParse(normalized);
    if (parsedDate != null) {
      final p = pattern ?? 'yyyy-MM-dd';
      final formatted = DateFormat(
        p,
        resolvedLocale,
      ).format(parsedDate.toLocal());
      return isArabic ? toArabicDigits(formatted) : formatted;
    }

    // If it is a string that might contain English month/day names or numbers
    String result = trimmed;
    if (isArabic) {
      result = localizeMonthAndDayNames(result);
      result = result
          .replaceAll(RegExp(r'\bAM\b', caseSensitive: false), 'ص')
          .replaceAll(RegExp(r'\bPM\b', caseSensitive: false), 'م');
      result = toArabicDigits(result);
    }
    return result;
  }

  /// Formats date and time localized for Arabic and English with localized digits and localized months.
  static String formatDateTime(
    dynamic dateStr,
    String? timeStr, {
    BuildContext? context,
    String? locale,
    String? pattern,
  }) {
    final resolvedLocale =
        locale ??
        (context != null
            ? Localizations.localeOf(context).languageCode
            : (Intl.defaultLocale?.startsWith('ar') == true ? 'ar' : 'en'));

    final hasTime = timeStr != null && timeStr.trim().isNotEmpty;
    final hasDate =
        dateStr != null &&
        (dateStr is DateTime || dateStr.toString().trim().isNotEmpty);

    if (hasTime) {
      final formattedTime = formatTo12Hour(
        timeStr,
        locale: resolvedLocale,
        context: context,
      );
      if (hasDate) {
        final formattedDate = formatDate(
          dateStr,
          locale: resolvedLocale,
          context: context,
          pattern: pattern,
        );
        return '$formattedDate • $formattedTime';
      }
      return formattedTime;
    }

    if (hasDate) {
      if (dateStr is DateTime) {
        final formattedDate = formatDate(
          dateStr,
          locale: resolvedLocale,
          context: context,
          pattern: pattern,
        );
        final formattedTime = formatTo12Hour(
          dateStr.toIso8601String(),
          locale: resolvedLocale,
          context: context,
        );
        return '$formattedDate • $formattedTime';
      }

      final dateString = dateStr.toString().trim();
      final normalized = toAsciiDigits(dateString);
      final parsed = DateTime.tryParse(normalized);
      if (parsed != null &&
          (normalized.contains('T') || normalized.contains(':'))) {
        final local = parsed.toLocal();
        final formattedDate = formatDate(
          local,
          locale: resolvedLocale,
          context: context,
          pattern: pattern,
        );
        final timeStr =
            '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
        final formattedTime = formatTo12Hour(
          timeStr,
          locale: resolvedLocale,
          context: context,
        );
        return '$formattedDate • $formattedTime';
      }

      final parts = dateString.split(RegExp(r'\s+'));
      if (parts.length >= 2 && parts.any((p) => p.contains(':'))) {
        final datePart = parts[0];
        final timePart = parts.sublist(1).join(' ');
        final formattedDate = formatDate(
          datePart,
          locale: resolvedLocale,
          context: context,
          pattern: pattern,
        );
        final formattedTime = formatTo12Hour(
          timePart,
          locale: resolvedLocale,
          context: context,
        );
        if (formattedDate.isNotEmpty && formattedTime.isNotEmpty) {
          return '$formattedDate • $formattedTime';
        }
      }

      final formattedTime = formatTo12Hour(
        dateString,
        locale: resolvedLocale,
        context: context,
      );
      if (formattedTime.isNotEmpty && formattedTime != dateString) {
        return formattedTime;
      }

      return formatDate(
        dateStr,
        locale: resolvedLocale,
        context: context,
        pattern: pattern,
      );
    }

    return '';
  }
}

extension TimeOfDayMinutesX on TimeOfDay {
  /// Returns the number of minutes since midnight (0–1439)
  int get minutesSinceMidnight => hour * 60 + minute;

  /// Returns 12-hour formatted time with AM/PM (uses English digits by default)
  String formatTimeOfDay([BuildContext? context, bool useArabicDigits = false]) {
    final hour12 = hour == 0 ? 12 : (hour > 12 ? hour - 12 : hour);
    final paddedHour = hour12.toString().padLeft(2, '0');
    final paddedMinute = minute.toString().padLeft(2, '0');
    if (useArabicDigits &&
        context != null &&
        Localizations.localeOf(context).languageCode == 'ar') {
      final periodStr = hour >= 12 ? 'م' : 'ص';
      return TimeFormatter.toArabicDigits('$paddedHour:$paddedMinute $periodStr');
    }
    final periodStr = hour >= 12 ? 'PM' : 'AM';
    return '$paddedHour:$paddedMinute $periodStr';
  }
}

extension StringTimeFormattingX on String {
  /// Formats the string into 12-hour format with AM/PM (or ص/م in Arabic) and localized digits
  String formatTo12Hour([BuildContext? context]) =>
      TimeFormatter.formatTo12Hour(this, context: context);

  String formatTo12HourLocale([String? locale]) =>
      TimeFormatter.formatTo12Hour(this, locale: locale);

  String formatDateLocalized([BuildContext? context, String? pattern]) =>
      TimeFormatter.formatDate(this, context: context, pattern: pattern);
}

extension NullableStringTimeFormattingX on String? {
  /// Formats the nullable string into 12-hour format with AM/PM (or ص/م in Arabic) and localized digits
  String formatTo12Hour([BuildContext? context]) =>
      TimeFormatter.formatTo12Hour(this, context: context);

  String formatTo12HourLocale([String? locale]) =>
      TimeFormatter.formatTo12Hour(this, locale: locale);

  String formatDateLocalized([BuildContext? context, String? pattern]) =>
      TimeFormatter.formatDate(this, context: context, pattern: pattern);
}

extension DateTimeFormattingX on DateTime {
  /// Formats the DateTime localized for current context with month and day names
  String formatDateLocalized([BuildContext? context, String? pattern]) =>
      TimeFormatter.formatDate(this, context: context, pattern: pattern);
}
