import 'package:intl/intl.dart';

class DatetimeConverter {
  String convert(value) {
    var dateTimeParsed = DateTime.parse(value);
    print(dateTimeParsed);
    var dateName = DateFormat.MMMM().format(dateTimeParsed);
    var dateFormat = DateFormat('dd yyyy');
    var timeFormat = DateFormat('HH:mm:ss');
    var outputDate = dateFormat.format(dateTimeParsed);
    var outputTime = timeFormat.format(dateTimeParsed);
    var time = '$dateName $outputDate $outputTime';

    return time;
  }
}
