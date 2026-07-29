// ignore_for_file: constant_identifier_names

import 'package:intl/intl.dart';

class AppDateFormat {
  static String format(String date, String pattern) {
    try {
      final parsed = DateTime.parse(date);
      return DateFormat(pattern).format(parsed);
    } catch (e) {
      return "Invalid date";
    }
  }
}
class AppFormats {
 

  static const yyyyMMdd = 'yyyy-MM-dd';
  // Example: 2026-04-21

  static const ddMMyyyy = 'dd-MM-yyyy';
  // Example: 21-04-2026

  static const MMddyyyy = 'MM/dd/yyyy';
  // Example: 04/21/2026

  static const ddMMyy = 'dd-MM-yy';
  // Example: 21-04-26

  static const MMMddyyyy = 'MMM dd, yyyy';
  // Example: Apr 21, 2026

  static const MMMMddyyyy = 'MMMM dd, yyyy';
  // Example: April 21, 2026

  static const ddMMMMyyyy = 'dd MMMM yyyy';
  // Example: 21 April 2026


  static const EEEddMMM = 'EEE, dd MMM yyyy';
  // Example: Tue, 21 Apr 2026

  static const EEEEddMMMM = 'EEEE, dd MMMM yyyy';
  // Example: Tuesday, 21 April 2026


  static const HHmm = 'HH:mm';
  // Example: 14:30 (24-hour format)

  static const HHmmss = 'HH:mm:ss';
  // Example: 14:30:45

  static const hhmmA = 'hh:mm a';
  // Example: 02:30 PM

  static const hhmmssA = 'hh:mm:ss a';
  // Example: 02:30:45 PM


  static const yyyyMMddHHmmss = 'yyyy-MM-dd HH:mm:ss';
  // Example: 2026-04-21 14:30:45

  static const ddMMMhhmmA = 'dd MMM yyyy, hh:mm a';
  // Example: 21 Apr 2026, 02:30 PM

  static const fullReadable = 'EEEE, MMMM d, yyyy h:mm a';
  // Example: Tuesday, April 21, 2026 2:30 PM


  static const compact = 'yyyyMMdd';
  // Example: 20260421

  static const fileSafe = 'yyyyMMdd_HHmmss';
  // Example: 20260421_143045
}