import 'package:intl/intl.dart';

class Converter {
  String dateTimeConvert(value) {
    var dateTimeParsed = DateTime.parse(value);
    var dateName = DateFormat.MMMM().format(dateTimeParsed);
    var dateFormat = DateFormat('dd yyyy');
    var timeFormat = DateFormat('HH:mm:ss');
    var outputDate = dateFormat.format(dateTimeParsed);
    var outputTime = timeFormat.format(dateTimeParsed);
    var time = '$dateName $outputDate $outputTime';

    return time;
  }

  String decimalPlaceFormat(value) {
    var formatter = NumberFormat('###,##0.00######').format(value);

    return formatter;
  }
}
