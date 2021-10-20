import 'package:intl/intl.dart';

class Converter {
  String dateTimeConvert(value) {
    final dateTimeParsed = DateTime.parse(value);
    final dateName = DateFormat.MMMM().format(dateTimeParsed);
    final dateFormat = DateFormat('dd yyyy');
    final timeFormat = DateFormat('HH:mm:ss');
    final outputDate = dateFormat.format(dateTimeParsed);
    final outputTime = timeFormat.format(dateTimeParsed);
    final time = '$dateName $outputDate $outputTime';

    return time;
  }

  String decimalPlaceFormat(value) {
    final formatter = NumberFormat('###,##0.00######').format(value);

    return formatter;
  }
}
