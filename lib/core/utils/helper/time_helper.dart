import 'package:intl/intl.dart';

class TimeHelper {
  static String utcToLocalTime(String timeStr) {
    try {
      final parts = timeStr.split(':');
      if (parts.length != 2) return timeStr;
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1]);

      final now = DateTime.now();
      // Create UTC time and convert to local
      final utcTime = DateTime.utc(now.year, now.month, now.day, hour, minute);
      final localTime = utcTime.toLocal();

      return "${localTime.hour.toString().padLeft(2, '0')}:${localTime.minute.toString().padLeft(2, '0')}";
    } catch (e) {
      return timeStr;
    }
  }

  static DateTime? utcToLocalDateTime(String dateStr, String timeStr) {
    try {
      DateTime date = DateTime.parse(dateStr);
      List<String> timeParts = timeStr.split(':');
      
      // Create UTC DateTime
      final utcDateTime = DateTime.utc(
        date.year,
        date.month,
        date.day,
        int.parse(timeParts[0]),
        int.parse(timeParts[1]),
      );
      
      // Return local DateTime
      return utcDateTime.toLocal();
    } catch (e) {
      return null;
    }
  }

  static String formatTimeRange(String startTimeStr, int durationMinutes) {
    try {
      List<String> parts = startTimeStr.split(':');
      int hour = int.parse(parts[0]);
      int minute = int.parse(parts[1]);
      
      // Since we want to format local time, we assume startTimeStr is already local
      DateTime startTime = DateTime(2000, 1, 1, hour, minute);
      DateTime endTime = startTime.add(Duration(minutes: durationMinutes));
      
      return "${DateFormat('HH:mm').format(startTime)} – ${DateFormat('HH:mm').format(endTime)}";
    } catch (e) {
      return startTimeStr;
    }
  }
}
