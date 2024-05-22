extension ExtensionDateTime on DateTime {
  String get formatBrazilianDate {
    return '$day/$month/$year';
  }

  String get formatBrazilianTime {
    return '$hour:$minute';
  }

  String get idGeneration {
    //return '$year$month$day$hour$minute$second';
    return DateTime.now().toString();
  }
}